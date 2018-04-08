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

      context 'and the user did not guess the score for that game' do
        it 'creates a new guess' do
          expect {
            described_class.save_guess(user: user, game: game, host_score: 3,
              visitor_score: 8)
          }.to change(UserGuess, :count).by(1)
        end
      end

      context 'and the user already has a guess for that game' do
        it 'updates the guess' do
          guess = described_class.save_guess(user: user, game: game, host_score: 3,
            visitor_score: 8)

          expect {
            second_guess = described_class.save_guess(user: user, game: game,
              host_score: 1, visitor_score: 2)
          }.to change(UserGuess, :count).by(0)

          guess.reload
          expect(guess.host_score).to eq(1)
          expect(guess.visitor_score).to eq(2)
        end
      end

      it 'saves the guess in the database' do
        guess = described_class.save_guess(user: user, game: game, host_score: 3,
          visitor_score: 8)

        expect(guess.host_score).to eq(3)
        expect(guess.visitor_score).to eq(8)
      end
    end
  end
end
