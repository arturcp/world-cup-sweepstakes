# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  include ActiveSupport::Testing::TimeHelpers

  let(:team) { teams(:brazil) }

  describe '#host' do
    context 'when game has a host' do
      let(:game) { described_class.new(host: team) }

      it 'uses the host\'s name' do
        expect(game.host.name).to eq('Brazil')
      end

      it 'uses the host\'s flag' do
        expect(game.host.flag).to eq('http://cdn.fake.com/pt-br.jpg')
      end
    end

    context 'when game has no host' do
      let(:game) { described_class.new }
      let(:default_team) { Team.default }

      it 'uses the host\'s name' do
        expect(game.host.name).to eq(default_team.name)
      end

      it 'uses the host\'s flag' do
        expect(game.host.flag).to eq(default_team.flag)
      end
    end
  end

  describe '#visitor' do
    context 'when game has a visitor' do
      let(:game) { described_class.new(visitor: team) }

      it 'uses the visitor\'s name' do
        expect(game.visitor.name).to eq('Brazil')
      end

      it 'uses the visitor\'s flag' do
        expect(game.visitor.flag).to eq('http://cdn.fake.com/pt-br.jpg')
      end
    end

    context 'when game has no visitor' do
      let(:game) { described_class.new }
      let(:default_team) { Team.default }

      it 'uses the visitor\'s name' do
        expect(game.visitor.name).to eq(default_team.name)
      end

      it 'uses the visitor\'s flag' do
        expect(game.visitor.flag).to eq(default_team.flag)
      end
    end
  end

  describe '#passed?' do
    let(:game) { games(:braxcol) }

    context 'when game will happen more than 1 hour from now' do
      it 'is not passed' do
        travel_to game.date - 10.days do
          expect(game).not_to be_passed
        end
      end
    end

    context 'when game will happen one hour from now' do
      it 'is passed' do
        travel_to game.date - 1.hour do
          expect(game).to be_passed
        end
      end
    end

    context 'when game is happening' do
      it 'is passed' do
        travel_to game.date do
          expect(game).to be_passed
        end
      end
    end

    context 'when game already happened' do
      it 'is passed' do
        travel_to game.date + 10.days do
          expect(game).to be_passed
        end
      end
    end
  end

  describe '#score' do
    let(:game) { games(:braxcol) }

    it 'formats the result in a string' do
      expect(game.score).to eq('2 x 1')
    end
  end

  describe '#title' do
    context 'when game has host and visitor' do
      let(:game) { games(:braxcol) }

      it 'formats the name of the teams' do
        expect(game.title).to eq('Brazil x Colombia')
      end
    end

    context 'when game has only host' do
      let(:team) { teams(:brazil) }
      let(:game) { Game.new(host: team) }

      it 'returns an empty string' do
        expect(game.title).to be_empty
      end
    end

    context 'when game has only visitor' do
      let(:team) { teams(:brazil) }
      let(:game) { Game.new(visitor: team) }

      it 'returns an empty string' do
        expect(game.title).to be_empty
      end
    end
  end
end
