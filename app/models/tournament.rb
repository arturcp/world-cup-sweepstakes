# frozen_string_literal: true

class Tournament < ApplicationRecord
  has_many :teams,  dependent: :destroy
  has_many :rounds,  dependent: :destroy

  belongs_to :user
end
