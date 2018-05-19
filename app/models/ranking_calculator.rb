# frozen_string_literal: true

class RankingCalculator
  attr_reader :game

  RULES = [
    Rules::WinnerRule,
    Rules::ScoreRule,
    Rules::PenaltiesRule,
    Rules::TieRule,
    Rules::ExtraTimeRule
  ].freeze

  def initialize(game)
    @game = game
  end

  def apply_rules
    return false unless valid_game?

    game.user_guesses.each do |guess|
      RULES.each do |rule_class|
        rule = rule_class.new(guess)
        points = rule.calculate
        next if points.zero?

        log(user: guess.user, guess: guess, points: points, reason: rule.reason)
      end
    end

    game.checked!

    true
  end

  private

  def valid_game?
    game.present? && game.pending?
  end

  def log(user:, guess:, points:, reason:)
    game = guess.game
    tournament = game.tournament

    RankingLog.create!(
      tournament: tournament,
      user: user,
      game: game,
      guess: guess.score,
      points: points,
      reason: reason
    )
  end
end
