# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserGuessesController, type: :request do
  describe 'POST #create' do
    let(:tournament) { tournaments(:world_cup) }
    let(:game) { games(:braxcol) }
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
          post user_guesses_tournament_path(tournament), params: {
            game_id: game.id, host_score: 4, visitor_score: 2, format: :json }

          expect(response.status).to eq(200)
        end

        it 'updates the host score' do
          post user_guesses_tournament_path(tournament), params: {
            game_id: game.id, host_score: 4, visitor_score: 2, format: :json }

          game.reload
          expect(game.host_score).to eq(4)
        end

        it 'updates the visitor score' do
          post user_guesses_tournament_path(tournament), params: {
            game_id: game.id, host_score: 4, visitor_score: 2, format: :json }

          game.reload
          expect(game.visitor_score).to eq(2)
        end

        it 'does not create a new game' do
          expect {
            post user_guesses_tournament_path(tournament), params: {
              game_id: game.id, host_score: 4, visitor_score: 2, format: :json }
          }.to change(Game, :count).by(0)
        end

        it 'does not create a user guess' do
          expect {
            post user_guesses_tournament_path(tournament), params: {
              game_id: game.id, host_score: 4, visitor_score: 2, format: :json }
          }.to change(UserGuess, :count).by(0)
        end
      end

      context 'and game does not exist' do
        it 'returns 404' do
          post user_guesses_tournament_path(tournament), params: {
            game_id: -1, host_score: 1, visitor_score: 2, format: :json }

          expect(response.status).to eq(404)
        end
      end
    end

    context 'when user is not admin of the tournament' do
      before { sign_in(user) }

      context 'and game exists' do
        it 'returns with success' do
          post user_guesses_tournament_path(tournament), params: {
            game_id: game.id, host_score: 1, visitor_score: 2, format: :json }

          expect(response.status).to eq(200)
        end

        context 'and the game already passed' do
          it 'creates a user guess' do
            allow_any_instance_of(Game).to receive(:passed?).and_return(true)

            expect {
              post user_guesses_tournament_path(tournament), params: {
                game_id: game.id, host_score: 4, visitor_score: 2, format: :json }
            }.to change(UserGuess, :count).by(0)
          end
        end

        context 'and the game did not happen yet' do
          it 'creates a user guess' do
            allow_any_instance_of(Game).to receive(:passed?).and_return(false)

            expect {
              post user_guesses_tournament_path(tournament), params: {
                game_id: game.id, host_score: 4, visitor_score: 2, format: :json }
            }.to change(UserGuess, :count).by(1)
          end
        end
      end

      context 'and game does not exist' do
        it 'returns 404' do
          post user_guesses_tournament_path(tournament), params: {
            game_id: -1, host_score: 1, visitor_score: 2, format: :json }

          expect(response.status).to eq(404)
        end
      end
    end

    context 'when user is not logged' do

      it 'returns unauthorized http status' do
        post user_guesses_tournament_path(tournament), params: {
          game_id: game.id, host_score: 1, visitor_score: 2, format: :json }

        expect(response.status).to eq(401)
      end
    end
  end
end
