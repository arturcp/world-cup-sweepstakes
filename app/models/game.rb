# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :round

  belongs_to :host, class_name: 'Team', optional: true
  belongs_to :visitor, class_name: 'Team', optional: true

  has_many :user_guesses, dependent: :destroy

  delegate :tournament, to: :round

  enum status: {
    pending: 0,
    checked: 1
  }

  def host
    super || Team.default
  end

  def visitor
    super || Team.default
  end

  def passed?
    date - 1.hour <= Time.current
  end

  def score
    "#{host_score} x #{visitor_score}"
  end

  def title
    return '' unless teams_defined?

    "#{host.name} x #{visitor.name}"
  end

  def penalties?
    !allows_tie && teams_defined? && tie?
  end

  def clone
    new_game = self.dup
    new_game.host_score = nil
    new_game.visitor_score = nil
    new_game.penalties_winner_id = nil

    new_game
  end

  def teams_defined?
    host_id.present? && visitor_id.present?
  end

  def tie?
    host_score == visitor_score && has_score?
  end

  def has_score?
    host_score.present? && visitor_score.present?
  end
end
