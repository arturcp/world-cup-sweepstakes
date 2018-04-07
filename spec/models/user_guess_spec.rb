# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserGuess, type: :model do
  describe '.save_guess' do
    let(:game) { games(:braxcol) }
    let(:user) { users(:jane_roe) }

    context 'when game has already passed' do
      before { allow(game).to receive(:passed?).and_return(true) }

      it 'does not creat a new guess' do
        expect(described_class).not_to receive(:create!)
        described_class.save_guess(user: user, game: game, host_score: 0,
          visitor_score: 1)
      end
    end

    context 'when game did not happen yet' do
      before { allow(game).to receive(:passed?).and_return(false) }

      it 'creates a new guess' do
        expect(described_class).to receive(:create!)
          .with(user: user, game: game, host_score: 0, visitor_score: 1)

        described_class.save_guess(user: user, game: game, host_score: 0,
          visitor_score: 1)
      end
    end
  end
end
