# frozen_string_literal: true

class UserGuess < ApplicationRecord
  belongs_to :user
  belongs_to :game

  def self.save_guess(user:, game:, host_score:, visitor_score:)
    return if game.passed?

    create!(user: user, game: game, host_score: host_score, visitor_score: visitor_score)
  end
end
