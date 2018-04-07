# frozen_literal_string: true

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
end
