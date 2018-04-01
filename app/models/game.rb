# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :round

  belongs_to :host, class_name: 'Team'
  belongs_to :seller, class_name: 'Team'
end
