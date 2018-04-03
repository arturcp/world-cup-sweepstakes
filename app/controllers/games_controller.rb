# frozen_string_literal: true

class GamesController < ApplicationController
  def index
    @tournament = Tournament.first
  end
end
