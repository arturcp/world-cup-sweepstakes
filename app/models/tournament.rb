# frozen_string_literal: true

class Tournament < ApplicationRecord
  has_many :teams
  has_many :rounds

  belongs_to :user
end
