# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @world_cup = Tournament.find_by(name: 'World Cup 2018')
  end
end
