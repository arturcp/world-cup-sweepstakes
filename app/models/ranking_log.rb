# frozen_string_literal: true

class RankingLog < ApplicationRecord
  belongs_to :tournament
  belongs_to :game
  belongs_to :user

  enum reason: {
    winner: 0,
    score: 1
  }
end
