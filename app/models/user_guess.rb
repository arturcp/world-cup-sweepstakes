# frozen_string_literal: true

class UserGuess < ApplicationRecord
  belongs_to :user
  belongs_to :game

  def self.save_guess(user:, game:, host_score:, visitor_score:)
    return if game.passed?

    guess = find_or_initialize_by(user: user, game: game)
    guess.host_score = host_score
    guess.visitor_score = visitor_score
    guess.save!

    guess
  end

  def score
    "#{host_score} x #{visitor_score}"
  end
end
