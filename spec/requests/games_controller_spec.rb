# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController, type: :request do
  describe 'PUT #update' do
    let(:tournament) { tournaments(:world_cup) }
    let(:game) { games(:unconfirmed) }
    let(:admin) { users(:john_doe) }
    let(:user) { users(:jane_roe) }
    let(:brazil) { teams(:brazil) }
    let(:colombia) { teams(:colombia) }
    let(:mexico) { teams(:mexico) }
    let(:braxcol) { games(:braxcol) }

    before do
      sign_out(user)
      sign_out(admin)
    end

    context 'when user is admin of the tournament' do
      before { sign_in(admin) }

      context 'and game exists' do
        context 'and host_id and visitor_id are present' do
          it 'returns with success' do
            put games_tournament_path(tournament), params: {
              game_id: game.id, host_id: brazil.id, visitor_id: colombia.id, format: :json }

            expect(response.status).to eq(200)
          end

          it 'updates the game with the id\'s' do
            expect(game.host_id).to be_nil
            expect(game.visitor_id).to be_nil
            put games_tournament_path(tournament), params: {
              game_id: game.id, host_id: brazil.id, visitor_id: mexico.id, format: :json }

            game.reload
            expect(game.host_id).to eq(brazil.id)
            expect(game.visitor_id).to eq(mexico.id)
          end

          it 'does not create a new game' do
            expect {
              put games_tournament_path(tournament), params: {
                game_id: game.id, host_id: brazil.id, visitor_id: colombia.id, format: :json }
            }.to change(Game, :count).by(0)
          end

          context 'but the game already have host_id or visitor_id' do
            it 'does not update the game' do
              expect_any_instance_of(Game).not_to receive(:update)

              put games_tournament_path(tournament), params: {
                game_id: braxcol.id, host_id: brazil.id, visitor_id: mexico.id, format: :json }
            end
          end
        end

        context 'and host_id is invalid' do
          it 'does not update the game' do
            expect_any_instance_of(Game).not_to receive(:update)

            put games_tournament_path(tournament), params: {
              game_id: game.id, host_id: nil, visitor_id: mexico.id, format: :json }
          end
        end

        context 'and visitor_id is invalid' do
          it 'does not update the game' do
            expect_any_instance_of(Game).not_to receive(:update)

            put games_tournament_path(tournament), params: {
              game_id: game.id, host_id: brazil.id, visitor_id: nil, format: :json }
          end
        end
      end

      context 'and game does not exist' do
        it 'returns 404' do
          put games_tournament_path(tournament), params: {
            game_id: -1, host_id: brazil.id, visitor_id: colombia.id, format: :json }

          expect(response.status).to eq(404)
        end
      end
    end

    context 'when user is not admin of the tournament' do
      before { sign_in(user) }

      context 'and game exists' do
        it 'returns with success' do
          put games_tournament_path(tournament), params: {
            game_id: game.id, host_id: brazil.id, visitor_id: colombia.id, format: :json }

          expect(response.status).to eq(200)
        end

        it 'does not update the game' do
          expect_any_instance_of(Game).not_to receive(:update)

          put games_tournament_path(tournament), params: {
            game_id: game.id, host_id: brazil.id, visitor_id: colombia.id, format: :json }
        end
      end
    end

    context 'when user is not logged' do
      it 'returns unauthorized http status' do
        put games_tournament_path(tournament), params: {
          game_id: game.id, host_id: brazil.id, visitor_id: colombia.id, format: :json }

        expect(response.status).to eq(401)
      end
    end
  end
end
