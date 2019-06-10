# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @world_cup = Tournament.find_by(name: 'Women\'s world cup 2019')
  end
end
