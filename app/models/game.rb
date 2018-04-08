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
end
