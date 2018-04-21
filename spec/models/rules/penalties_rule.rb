# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rules::PenaltiesRule, type: :rule do
  describe '#calculate' do
    let(:rule) { described_class.new(guess) }
    let(:brazil) { teams(:brazil) }
    let(:colombia) { teams(:colombia) }

    context 'when game allows tie and it is a tie' do
      context 'and the user guesses the host won' do
        let(:game) { Game.new(host: brazil, host_score: 1, visitor_score: 1, allows_tie: true) }
        let(:guess) { UserGuess.new(game: game, penalties_winner_id: brazil.id) }

        it 'gives 0 points to the user' do
          expect(rule.calculate).to be_zero
        end
      end

      context 'and the user guesses the visitor won' do
        let(:game) { Game.new(visitor: brazil, host_score: 1, visitor_score: 1, allows_tie: true) }
        let(:guess) { UserGuess.new(game: game, penalties_winner_id: brazil.id) }

        it 'gives 0 points to the user' do
          expect(rule.calculate).to be_zero
        end
      end
    end

    context 'when it is not a tie' do
      context 'and the user guesses the host won' do
        let(:game) { Game.new(host: brazil, host_score: 1, visitor_score: 2, allows_tie: true) }
        let(:guess) { UserGuess.new(game: game, penalties_winner_id: brazil.id) }

        it 'gives 0 points to the user' do
          expect(rule.calculate).to be_zero
        end
      end

      context 'and the user guesses the visitor won' do
        let(:game) { Game.new(visitor: brazil, host_score: 1, visitor_score: 1, allows_tie: true) }
        let(:guess) { UserGuess.new(game: game, penalties_winner_id: brazil.id) }

        it 'gives 0 points to the user' do
          expect(rule.calculate).to be_zero
        end
      end
    end

    context 'when game ends in penalties' do
      context 'and the user guesses the host won' do
        let(:game) { Game.new(host: brazil, visitor: colombia, host_score: 1,
          visitor_score: 1, allows_tie: false, penalties_winner_id: brazil.id) }
        let(:guess) { UserGuess.new(game: game, penalties_winner_id: brazil.id) }

        it 'gives 1 point to the user' do
          expect(rule.calculate).to eq(1)
        end
      end

      context 'and the user guesses wrongly that the host won' do
        let(:game) { Game.new(host: brazil, visitor: colombia, host_score: 1,
          visitor_score: 1, allows_tie: false, penalties_winner_id: colombia.id) }
        let(:guess) { UserGuess.new(game: game, penalties_winner_id: brazil.id) }

        it 'gives 0 points to the user' do
          expect(rule.calculate).to be_zero
        end
      end

      context 'and the user guesses the visitor won' do
        let(:game) { Game.new(host: brazil, visitor: colombia, host_score: 1, visitor_score: 1, allows_tie: false, penalties_winner_id: colombia.id) }
        let(:guess) { UserGuess.new(game: game, penalties_winner_id: colombia.id) }

        it 'gives 1 point to the user' do
          expect(rule.calculate).to eq(1)
        end
      end

      context 'and the user guesses wrongly that the visitor won' do
        let(:game) { Game.new(host: brazil, visitor: colombia, host_score: 1, visitor_score: 1, allows_tie: false, penalties_winner_id: brazil.id) }
        let(:guess) { UserGuess.new(game: game, penalties_winner_id: colombia.id) }

        it 'gives 0 points to the user' do
          expect(rule.calculate).to be_zero
        end
      end
    end
  end
end
