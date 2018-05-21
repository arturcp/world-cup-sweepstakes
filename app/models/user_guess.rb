# frozen_string_literal: true

class UserGuess < ApplicationRecord
  extend Forwardable

  belongs_to :user
  belongs_to :game

  def_delegators :game, :host, :visitor, :date, :place, :allows_tie,
    :passed?, :checked?, :host_id, :visitor_id,
    :teams_defined?

  def self.save_guess(user:, game:, host_score:, visitor_score:)
    return if game.passed? || game.checked?

    guess = find_or_initialize_by(user: user, game: game)
    guess.host_score = host_score
    guess.visitor_score = visitor_score
    guess.save!

    guess
  end

  def update_extra_time(host_score, visitor_score)
    return if game.passed? || game.checked?

    if tie?
      update(extra_time_host_score: host_score, extra_time_visitor_score: visitor_score, penalties_winner_id: nil)
    else
      update(extra_time_host_score: 0, extra_time_visitor_score: 0, penalties_winner_id: nil)
    end
  end

  def score
    "#{host_score} x #{visitor_score}"
  end

  def extra_time_score
    return nil unless extra_time_host_score && extra_time_visitor_score

    "#{extra_time_host_score} x #{extra_time_visitor_score}"
  end

  def tie?
    host_score == visitor_score && has_score?
  end

  def has_score?
    host_score.present? && visitor_score.present?
  end

  def extra_time_tie?
    extra_time_host_score == extra_time_visitor_score && has_extra_time_score?
  end

  def has_extra_time_score?
    extra_time_host_score.present? && extra_time_visitor_score.present?
  end

  def penalties?
    !allows_tie && teams_defined? && tie? && extra_time_tie?
  end
end
