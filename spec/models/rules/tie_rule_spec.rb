# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rules::TieRule, type: :rule do
  describe 'calculate' do
    let(:brazil) { teams(:brazil) }
    let(:colombia) { teams(:colombia) }

    context 'when user guesses the game was going to draw' do
      context 'when game is not confirmed' do
        let(:game) { games(:unconfirmed) }
        let(:guess) { UserGuess.new(game: game, host_score: 1, visitor_score: 1) }

        it { expect(described_class.new(guess).calculate).to be_zero }
      end

      context 'when game has no host score' do
        let(:game) { games(:with_no_host_score) }
        let(:guess) { UserGuess.new(game: game, host_score: 1, visitor_score: 1) }

        it { expect(described_class.new(guess).calculate).to be_zero }
      end

      context 'when game has no visitor score' do
        let(:game) { games(:with_no_visitor_score) }
        let(:guess) { UserGuess.new(game: game, host_score: 1, visitor_score: 1) }

        it { expect(described_class.new(guess).calculate).to be_zero }
      end

      context 'when host won the game' do
        let(:game) { games(:braxcol) }
        let(:guess) { UserGuess.new(game: game, host_score: 1, visitor_score: 1) }

        it { expect(described_class.new(guess).calculate).to be_zero }
      end

      context 'when visitor won the game' do
        let(:game) { games(:colxbra) }
        let(:guess) { UserGuess.new(game: game, host_score: 1, visitor_score: 1) }

        it { expect(described_class.new(guess).calculate).to be_zero }
      end

      context 'when the game ended draw' do
        let(:game) { games(:visitor_wins_penalties) }

        context 'and the score matches' do
          let(:guess) { UserGuess.new(game: game, host_score: 1, visitor_score: 1) }
          it { expect(described_class.new(guess).calculate).to eq(0) }
        end

        context 'and the score does not match' do
          let(:guess) { UserGuess.new(game: game, host_score: 9, visitor_score: 9) }
          it { expect(described_class.new(guess).calculate).to eq(1) }
        end
      end
    end

    context 'when user bets in the host' do
      let(:game) { games(:braxcol) }
      let(:guess) { UserGuess.new(game: game, host_score: 3, visitor_score: 1) }

      it { expect(described_class.new(guess).calculate).to be_zero }
    end

    context 'when user bets in the visitor' do
      let(:game) { games(:braxcol) }
      let(:guess) { UserGuess.new(game: game, host_score: 3, visitor_score: 4) }

      it { expect(described_class.new(guess).calculate).to be_zero }
    end
  end
end
