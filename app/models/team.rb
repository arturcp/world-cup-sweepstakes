# frozen_string_literal: true

class Team < ApplicationRecord
  belongs_to :tournament

  def self.default
    new(name: 'To confirm', flag: 'http://www.get-emoji.com/images/emoji/26bd.png')
  end
end
