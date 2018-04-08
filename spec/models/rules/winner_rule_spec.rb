# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rules::WinnerRule, type: :rule do
  describe 'calculate' do
    let(:user) { users(:john_doe) }
    let(:brazil) { teams(:brazil) }
    let(:colombia) { teams(:colombia) }

    it 'gives one point if user guessed the host won' do
      game = Game.new(host: brazil, visitor: colombia, host_score: 3, visitor_score: 2)
      guess = UserGuess.new(user: user, game: game, host_score: 2, visitor_score: 0)
      allow(guess).to receive(:game).and_return(game)

      expect(described_class.new(guess).calculate).to eq(1)
    end

    it 'gives one point if user guessed the visitor won' do
      game = Game.new(host: brazil, visitor: colombia, host_score: 1, visitor_score: 2)
      guess = UserGuess.new(user: user, game: game, host_score: 2, visitor_score: 3)
      allow(guess).to receive(:game).and_return(game)

      expect(described_class.new(guess).calculate).to eq(1)
    end

    it 'gives one point if user guessed the game draw' do
      game = Game.new(host: brazil, visitor: colombia, host_score: 2, visitor_score: 2)
      guess = UserGuess.new(user: user, game: game, host_score: 3, visitor_score: 3)
      allow(guess).to receive(:game).and_return(game)

      expect(described_class.new(guess).calculate).to eq(1)
    end

    it 'gives no points if the user bet in the host, but the visitor won' do
      game = Game.new(host: brazil, visitor: colombia, host_score: 0, visitor_score: 2)
      guess = UserGuess.new(user: user, game: game, host_score: 3, visitor_score: 1)
      allow(guess).to receive(:game).and_return(game)

      expect(described_class.new(guess).calculate).to be_zero
    end

    it 'gives no points if the user bet in the host, but it was a draw' do
      game = Game.new(host: brazil, visitor: colombia, host_score: 0, visitor_score: 0)
      guess = UserGuess.new(user: user, game: game, host_score: 3, visitor_score: 1)
      allow(guess).to receive(:game).and_return(game)

      expect(described_class.new(guess).calculate).to be_zero
    end

    it 'gives no points if the user bet in the visitor, but the host won' do
      game = Game.new(host: brazil, visitor: colombia, host_score: 1, visitor_score: 0)
      guess = UserGuess.new(user: user, game: game, host_score: 0, visitor_score: 1)
      allow(guess).to receive(:game).and_return(game)

      expect(described_class.new(guess).calculate).to be_zero
    end

    it 'gives no points if the user bet in the visitor, but it was a draw' do
      game = Game.new(host: brazil, visitor: colombia, host_score: 0, visitor_score: 0)
      guess = UserGuess.new(user: user, game: game, host_score: 0, visitor_score: 1)
      allow(guess).to receive(:game).and_return(game)

      expect(described_class.new(guess).calculate).to be_zero
    end

    it 'gives no points if the user bet in a draw, but the host won' do
      game = Game.new(host: brazil, visitor: colombia, host_score: 2, visitor_score: 0)
      guess = UserGuess.new(user: user, game: game, host_score: 0, visitor_score: 0)
      allow(guess).to receive(:game).and_return(game)

      expect(described_class.new(guess).calculate).to be_zero
    end

    it 'gives no points if the user bet in a draw, but the visitor won' do
      game = Game.new(host: brazil, visitor: colombia, host_score: 0, visitor_score: 2)
      guess = UserGuess.new(user: user, game: game, host_score: 1, visitor_score: 1)
      allow(guess).to receive(:game).and_return(game)

      expect(described_class.new(guess).calculate).to be_zero
    end
  end

  describe '#reason' do
    it 'returns :winner' do
      expect(described_class.new(nil).reason).to eq(:winner)
    end
  end
end
