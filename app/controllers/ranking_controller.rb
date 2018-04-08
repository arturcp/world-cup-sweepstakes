# frozen_string_literal: true

class RankingController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    if current_user.tournament_admin?(tournament)
      RankingCalculator.new(game).apply_rules
    end

    head :ok
  end

  private

  private

  def tournament
    @tournament ||= Tournament.find_by(slug: params[:tournament_name])
  end

  def game
    @game ||= Game.find(params[:game_id])
  end
end
