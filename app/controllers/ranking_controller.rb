# frozen_string_literal: true

class RankingController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :authenticate_user!, only: :create
  skip_before_action :verify_authenticity_token, only: :create

  def index
    @tournament = Tournament.find_by(slug: params[:tournament_name])
    @ranking = Ranking.fetch(@tournament)
  end

  def show
    @log = RankingLog
      .where(tournament: tournament, user_id: params[:user_id])
      .order(:created_at)

    render :show, layout: false
  end

  def create
    if current_user.tournament_admin?(tournament)
      RankingCalculator.new(game).apply_rules
    end

    head :ok
  end

  private

  def tournament
    @tournament ||= Tournament.find_by(slug: params[:tournament_name])
  end

  def game
    @game ||= Game.find(params[:game_id])
  end
end
