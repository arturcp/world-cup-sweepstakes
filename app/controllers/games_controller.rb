# frozen_string_literal: true

class GamesController < ApplicationController
  def index
    @tournament = Tournament.friendly.find(params[:tournament_name])
  end
end
