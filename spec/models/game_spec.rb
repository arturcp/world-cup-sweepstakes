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

  describe '#penalties' do
    let(:round) { rounds(:first_round) }
    let(:host) { teams(:brazil) }
    let(:visitor) { teams(:colombia) }
    let(:host_score) { 1 }
    let(:visitor_score) { 1 }

    let(:extra_time_host_score) { nil }
    let(:extra_time_visitor_score) { nil }

    let(:game) do
      Game.new(round: round, allows_tie: allows_tie, host: host,
        visitor: visitor, host_score: host_score, visitor_score: visitor_score,
        extra_time_host_score: extra_time_host_score,
        extra_time_visitor_score: extra_time_visitor_score)
    end

    context 'when game allows tie' do
      let(:allows_tie) { true }

      it 'returns false' do
        expect(game).not_to be_penalties
      end
    end

    context 'when game does not allow ties' do
      let(:allows_tie) { false }

      context 'when game does not have a defined host' do
        let(:host) { nil }

        it 'returns false' do
          expect(game).not_to be_penalties
        end
      end

      context 'when game does not have a defined visitor' do
        let(:visitor) { nil }

        it 'returns false' do
          expect(game).not_to be_penalties
        end
      end

      context 'when game does not have a defined host score' do
        let(:host_score) { nil }

        it 'returns false' do
          expect(game).not_to be_penalties
        end
      end

      context 'when game does not have a defined visitor score' do
        let(:visitor_score) { nil }

        it 'returns false' do
          expect(game).not_to be_penalties
        end
      end

      context 'when the scores don\'t match' do
        let(:host_score) { 2 }
        let(:visitor_score) { 1 }

        it 'returns false' do
          expect(game).not_to be_penalties
        end
      end

      context 'when game ended in a tie but the extra time had a winner' do
        let(:extra_time_host_score) { 1 }
        let(:extra_time_visitor_score) { 0 }

        it 'returns false' do
          expect(game).not_to be_penalties
        end
      end

      context 'when game ended in a tie but the extra time is not defined yet' do
        it 'returns false' do
          expect(game).not_to be_penalties
        end
      end

      context 'when game ended in a tie with penalties' do
        let(:extra_time_host_score) { 0 }
        let(:extra_time_visitor_score) { 0 }

        it 'returns true' do
          expect(game).to be_penalties
        end
      end
    end
  end

  describe '#clone' do
    let(:game) { games(:braxcol) }
    let(:cloned_game) { game.clone }

    it 'returns an instance of game' do
      expect(cloned_game).to be_a Game
    end

    it 'has no id' do
      expect(cloned_game.id).to be_nil
    end

    it 'does not have host_score' do
      expect(cloned_game.host_score).to be_nil
    end

    it 'does not have visitor_score' do
      expect(cloned_game.visitor_score).to be_nil
    end

    it 'does not have a penalty winner' do
      expect(cloned_game.penalties_winner_id).to be_nil
    end

    it 'has the same host_id' do
      expect(cloned_game.host_id).to eq(game.host_id)
    end

    it 'has the same visitor_id' do
      expect(cloned_game.visitor_id).to eq(game.visitor_id)
    end

    it 'has the same place' do
      expect(cloned_game.place).to eq(game.place)
    end

    it 'has the same date' do
      expect(cloned_game.date).to eq(game.date)
    end

    it 'has the same round' do
      expect(cloned_game.round_id).to eq(game.round_id)
    end
  end

  describe '#teams_defined?' do
    let(:brazil) { teams(:brazil) }
    let(:colombia) { teams(:colombia) }

    context 'when only host is defined' do
      it 'returns false' do
        expect(described_class.new(host: brazil)).not_to be_teams_defined
      end
    end

    context 'when only visitor is defined' do
      it 'returns false' do
        expect(described_class.new(visitor: colombia)).not_to be_teams_defined
      end
    end

    context 'when host and visitor are defined' do
      it 'returns true' do
        expect(described_class.new(host: brazil, visitor: colombia)).to be_teams_defined
      end
    end
  end

  describe '#has_score?' do
    context 'when only host has score' do
      it 'returns false' do
        expect(described_class.new(host_score: 1)).not_to be_has_score
      end
    end

    context 'when only visitor has score' do
      it 'returns false' do
        expect(described_class.new(visitor_score: 2)).not_to be_has_score
      end
    end

    context 'when both host and visitor have scores' do
      it 'returns true' do
        expect(described_class.new(host_score: 1, visitor_score: 1)).to be_has_score
      end
    end
  end

  describe '#has_extra_time_score?' do
    context 'when only host has extra time score' do
      it 'returns false' do
        expect(described_class.new(extra_time_host_score: 1)).not_to be_has_extra_time_score
      end
    end

    context 'when only visitor has extra time score' do
      it 'returns false' do
        expect(described_class.new(extra_time_visitor_score: 2)).not_to be_has_extra_time_score
      end
    end

    context 'when both host and visitor have extra time scores' do
      it 'returns true' do
        expect(described_class.new(extra_time_host_score: 1, extra_time_visitor_score: 1)).to be_has_extra_time_score
      end
    end
  end

  describe '#tie?' do
    context 'when both host and visitor have scores' do
      context 'and host and visitor have the same score' do
        it 'returns true' do
          expect(described_class.new(host_score: 1, visitor_score: 1)).to be_tie
        end
      end

      context 'and host and visitor have different scores' do
        it 'returns false' do
          expect(described_class.new(host_score: 1, visitor_score: 2)).not_to be_tie
        end
      end
    end

    context 'when the game has not a complete score set' do
      context 'and only host has score' do
        it 'returns false' do
          expect(described_class.new(host_score: 1)).not_to be_tie
        end
      end

      context 'and only visitor has score' do
        it 'returns false' do
          expect(described_class.new(visitor_score: 2)).not_to be_tie
        end
      end
    end
  end

  describe '#extra_time_tie?' do
    context 'when both host and visitor have extra time scores' do
      context 'and host and visitor have the same score' do
        it 'returns true' do
          expect(described_class.new(extra_time_host_score: 1, extra_time_visitor_score: 1)).to be_extra_time_tie
        end
      end

      context 'and host and visitor have different scores' do
        it 'returns false' do
          expect(described_class.new(extra_time_host_score: 1, extra_time_visitor_score: 2)).not_to be_extra_time_tie
        end
      end
    end

    context 'when the game has not a complete extra time score set' do
      context 'and only host has score' do
        it 'returns false' do
          expect(described_class.new(extra_time_host_score: 1)).not_to be_extra_time_tie
        end
      end

      context 'and only visitor has score' do
        it 'returns false' do
          expect(described_class.new(extra_time_visitor_score: 2)).not_to be_extra_time_tie
        end
      end
    end
  end
end
