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

  private

  def tournament
    @tournament ||= Tournament.friendly.find(params[:tournament_name])
  end

  def permitted_params
    params.permit(:game_id, :host_score, :visitor_score)
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
end
