# frozen_string_literal: true

class GamesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: :update

  def index
    @tournament = Tournament.friendly.find(params[:tournament_name])
  end

  def update
    if valid_for_update?
      game.update(host_id: permitted_params[:host_id], visitor_id: permitted_params[:visitor_id])
    end

    head :ok
  end

  private

  def tournament
    @tournament ||= Tournament.friendly.find(params[:tournament_name])
  end

  def permitted_params
    params.permit(:game_id, :host_id, :visitor_id)
  end

  def game
    @game ||= Game.find(permitted_params[:game_id])
  end

  def valid_for_update?
    current_user.tournament_admin?(tournament) && game.host_id.nil? &&
      game.visitor_id.nil? && permitted_params[:host_id].present? &&
      permitted_params[:visitor_id].present?
  end
end
