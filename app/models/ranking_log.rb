# frozen_string_literal: true

class RankingLog < ApplicationRecord
  belongs_to :tournament
  belongs_to :game
  belongs_to :user

  enum reason: {
    winner: 0,
    score: 1,
    penalties_winner: 2,
    draw: 3,
    extra_time_score: 4
  }
end
