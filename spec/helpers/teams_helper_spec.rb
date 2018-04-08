# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TeamsHelper, type: :helper do
  describe '.teams_for_select' do
    let(:brazil) { teams(:brazil) }
    let(:colombia) { teams(:colombia) }
    let(:russia) { teams(:russia) }
    let(:mexico) { teams(:mexico) }

    it 'creates options for all teams' do
      expect(helper.teams_for_select).to eq([
        ['Brazil', brazil.id], ['Colombia', colombia.id],
        ['Mexico', mexico.id], ['Russia', russia.id]
      ])
    end
  end
end
