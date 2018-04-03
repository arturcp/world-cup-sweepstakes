# frozen_string_literal: true

class Round < ApplicationRecord
  belongs_to :tournament
  has_many :games,  dependent: :destroy
end
