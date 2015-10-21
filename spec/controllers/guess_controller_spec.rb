require 'rails_helper'

RSpec.describe GuessController, type: :controller do
  let(:true_service) { Proc.new { true } }
  let(:false_service) { Proc.new { false } }
  let(:game) { Game.create!(word: 'BUCKET') }

  describe 'PUT /game/1/guess' do
    subject { response }

    render_views

    context 'with game_id = 1, no guess' do
      before do
        put :create, game_id: game.id 
      end

      it 'redirects to the game with alert guess_is_invalid' do
        expect(response).to redirect_to controller: :game, action: :show, id: game.id
        expect(flash[:alert]).to eq(GuessController::ERROR_MESSAGES[:guess_is_invalid])
      end
    end

    context 'with valid game, letter = "A"' do

      it 'makes a new guess' do
        expect {
          put :create, game_id: game.id, letter: 'A'
        }.to change(Guess, :count).by(1)
      end

      it 'redirects to the game with no flash' do
        put :create, game_id: game.id, letter: 'A'

        expect(response).to redirect_to controller: :game, action: :show, id: game.id
      end
    end

    context 'with valid game, letter has already been guessed' do
      before do
        game.guesses.create!(letter: 'A')

        put :create, game_id: game.id, letter: 'A'
      end

      it 'redirects to the game with alert letter_has_been_guessed' do
        expect(response).to redirect_to controller: :game, action: :show, id: game.id
        expect(flash[:alert]).to eq(GuessController::ERROR_MESSAGES[:letter_has_been_guessed])
      end
    end

    context 'with valid game, game is finished' do
      let(:guesses_to_win) { %w( B U C K E T) }

      before do
        guesses_to_win.each do |letter|
          game.guesses.create!(letter: letter)
        end

        put :create, game_id: game.id, letter: 'A'
      end
      it 'redirects to the game with alert game_over' do
        expect(response).to redirect_to controller: :game, action: :show, id: game.id
        expect(flash[:alert]).to eq(GuessController::ERROR_MESSAGES[:game_over])
      end
    end

    context 'with invalid game, valid guess' do
      let(:invalid_game_id) { 99999 }

      before do
        put :create, game_id: invalid_game_id, letter: 'A'
      end
      it 'redirects to the index with alert game does not exist' do
        expect(response).to redirect_to controller: :game, action: :index
        expect(flash[:alert]).to eq(GuessController::ERROR_MESSAGES[:game_does_not_exist])
      end
    end
  end
end
