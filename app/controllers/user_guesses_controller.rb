# frozen_string_literal: true

class UserGuessesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    if current_user.tournament_admin?(tournament)
      game.update!(host_score: host_score, visitor_score: visitor_score)
    else
      UserGuess.save_guess(user: current_user, game: game,
        host_score: host_score, visitor_score: visitor_score)
    end

    head :ok
  end

  def update
    send("update_#{params[:step]}")

    head :ok
  end

  private

  def tournament
    @tournament ||= Tournament.friendly.find(params[:tournament_name])
  end

  def permitted_params
    params.permit(:game_id, :host_score, :visitor_score, :tournament_name,
      :winner_id, :step, extra_time: {})
  end

  def game
    @game ||= Game.find(permitted_params[:game_id])
  end

  def host_score
    permitted_params[:host_score].to_i
  end

  def visitor_score
    permitted_params[:visitor_score].to_i
  end

  def update_extra_time
    return if game.allows_tie?

    host_score = permitted_params.dig(:extra_time, :host_score)
    visitor_score = permitted_params.dig(:extra_time, :visitor_score)

    if current_user.tournament_admin?(tournament) && game.tie?
      game.update!(extra_time_host_score: host_score, extra_time_visitor_score: visitor_score)
    else
      return if game.passed? || game.checked?

      user_guess = UserGuess.find_by(user: current_user, game: game)
      user_guess&.update_extra_time(host_score, visitor_score)
    end
  end

  def update_penalties
    return if game.allows_tie?

    winner_id = params[:winner_id].to_i

    if current_user.tournament_admin?(tournament)
      if game.penalties? && [game.host_id, game.visitor_id].include?(winner_id)
        game.update!(penalties_winner_id: winner_id)
      end
    else
      return if game.passed? || game.checked?

      user_guess = UserGuess.find_by(user: current_user, game: game)

      if user_guess.penalties? && [user_guess.host_id, user_guess.visitor_id].include?(winner_id)
        user_guess&.update(penalties_winner_id: winner_id)
      end
    end
  end
end
