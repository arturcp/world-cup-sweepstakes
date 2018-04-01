# frozen_string_literal: true

class Tournament < ApplicationRecord
  has_many :teams
  has_many :rounds
end
