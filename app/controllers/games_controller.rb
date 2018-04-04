# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @tournament = Tournament.friendly.find(params[:tournament_name])
  end
end
