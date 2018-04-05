# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :round

  belongs_to :host, class_name: 'Team', optional: true
  belongs_to :visitor, class_name: 'Team', optional: true

  def host
    super || Team.default
  end

  def visitor
    super || Team.default
  end
end
