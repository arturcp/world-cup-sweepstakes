# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RankingCalculator, type: :model do
  let(:user) { users(:john_doe) }

  describe '#apply_rules' do
    context 'when game is nil' do
      it 'returns false' do
        expect(described_class.new(nil).apply_rules).to be_falsy
      end

      it 'does not try to change the game status' do
        expect_any_instance_of(Game).not_to receive(:checked!)
        described_class.new(nil).apply_rules
      end
    end

    context 'when game is checked' do
      let(:game) { games(:braxcol) }
      before { allow(game).to receive(:pending?).and_return(false) }

      it 'returns false' do
        expect(described_class.new(game).apply_rules).to be_falsy
      end

      it 'does not try to change the game status' do
        expect_any_instance_of(Game).not_to receive(:checked!)
        described_class.new(game).apply_rules
      end
    end

    context 'when game is valid' do
      let(:game) { games(:braxcol) }
      let(:second_game) { games(:rusxmex) }
      let(:third_game) { games(:braxrus) }

      context 'but the game has no guesses' do
        it 'returns true' do
          expect(described_class.new(game).apply_rules).to be_truthy
        end

        it 'changes the status of the game to `checked`' do
          expect(game).to be_pending
          described_class.new(game).apply_rules
          expect(game).to be_checked
        end
      end

      context 'and the game has guesses' do
        it 'returns true' do
          expect(described_class.new(game).apply_rules).to be_truthy
        end

        it 'changes the status of the game to `checked`' do
          expect(game).to be_pending
          described_class.new(game).apply_rules
          expect(game).to be_checked
        end

        it 'logs the results in the ranking_logs table' do
          expect(RankingLog).to receive(:create!)
            .with(
              tournament: game.tournament,
              user: user,
              game: third_game,
              guess: '3 x 0',
              extra_time_guess: nil,
              points: 3,
              reason: :score
            ).once

          described_class.new(third_game).apply_rules
        end

        it 'creates a new log entry' do
          expect {
            described_class.new(game).apply_rules
          }.to change(RankingLog, :count).by(1)
        end

        it 'does not log wrong guesses' do
          guess = user_guesses(:john_second_guess)
          expect(RankingLog).not_to receive(:create!)

          described_class.new(second_game).apply_rules
        end
      end
    end
  end
end
