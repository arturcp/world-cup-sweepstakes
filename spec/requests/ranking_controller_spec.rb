# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RankingController, type: :request do
  describe 'POST #create' do
    let(:tournament) { tournaments(:world_cup) }
    let(:game) { games(:braxcol) }
    let(:second_game) { games(:rusxmex) }
    let(:admin) { users(:john_doe) }
    let(:user) { users(:jane_roe) }

    before do
      sign_out(user)
      sign_out(admin)
    end

    context 'when user is admin of the tournament' do
      before { sign_in(admin) }

      context 'and game exists' do
        it 'returns with success' do
          post ranking_tournament_path(tournament), params: { game_id: game.id, format: :json }

          expect(response.status).to eq(200)
        end

        it 'updates the game status' do
          post ranking_tournament_path(tournament), params: { game_id: game.id, format: :json }

          game.reload
          expect(game).to be_checked
        end

        context 'and the user made points with the guess' do
          it 'creates a log' do
            expect {
              post ranking_tournament_path(tournament), params: { game_id: game.id, format: :json }
            }.to change(RankingLog, :count).by(1)
          end
        end

        context 'and the user did not make points with the guess' do
          it 'does not create a log' do
            expect {
              post ranking_tournament_path(tournament), params: { game_id: second_game.id, format: :json }
            }.to change(RankingLog, :count).by(0)
          end
        end
      end

      context 'and game does not exist' do
        it 'returns 404' do
          post ranking_tournament_path(tournament), params: { game_id: -1, format: :json }

          expect(response.status).to eq(404)
        end
      end
    end

    context 'when user is not admin of the tournament' do
      before { sign_in(user) }

      context 'and game exists' do
        it 'returns with success' do
          post ranking_tournament_path(tournament), params: { game_id: game.id, format: :json }

          expect(response.status).to eq(200)
        end

        it 'does not call the ranking calculator' do
          expect_any_instance_of(RankingCalculator).not_to receive(:apply_rules)

          post ranking_tournament_path(tournament), params: { game_id: game.id, format: :json }
        end

        it 'does not create a log' do
          expect {
            post ranking_tournament_path(tournament), params: { game_id: second_game.id, format: :json }
          }.to change(RankingLog, :count).by(0)
        end
      end

      context 'and game does not exist' do
        it 'returns 404' do
          post ranking_tournament_path(tournament), params: { game_id: -1, format: :json }

          expect(response.status).to eq(200)
        end
      end
    end

    context 'when user is not logged' do
      it 'returns unauthorized http status' do
        post ranking_tournament_path(tournament), params: { game_id: game.id, format: :json }

        expect(response.status).to eq(401)
      end
    end
  end
end
