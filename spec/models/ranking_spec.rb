# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ranking, type: :model do
  describe '.fetch' do
    let(:tournament) { tournaments(:world_cup) }

    it 'groups the logs and sums the points of the users' do
      ranking = described_class.fetch(tournament)

      expect(ranking.first.name).to eq('Jane Roe')
      expect(ranking.first.total_points).to eq(4)
      expect(ranking[1].name).to eq('John Doe')
      expect(ranking[1].total_points).to eq(1)
    end
  end
end
