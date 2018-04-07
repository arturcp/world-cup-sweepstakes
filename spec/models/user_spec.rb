# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#domain_check' do
    context 'when email domain is in the whitelist' do
      let(:user) { users(:john_doe) }

      it 'is valid' do
        expect(user).to be_valid
      end
    end

    context 'when email domain is not in the whitelist' do
      let(:user) { users(:outsider) }

      it 'is invalid' do
        expect(user).not_to be_valid
      end
    end
  end

  describe '#tournament_admin?' do
    let(:tournament) { tournaments(:world_cup) }

    context 'when user is the administrator of the tournament' do
      let(:user) { users(:john_doe) }

      it 'returns true' do
        expect(user.tournament_admin?(tournament)).to be_truthy
      end
    end

    context 'when user is not the administrator of the tournament' do
      let(:user) { users(:outsider) }

      it 'returns false' do
        expect(user.tournament_admin?(tournament)).to be_falsy
      end
    end
  end
end
