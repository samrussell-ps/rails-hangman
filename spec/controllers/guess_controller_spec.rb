require 'rails_helper'

RSpec.describe GuessController, type: :controller do
  let(:true_service) { Proc.new { true } }
  let(:false_service) { Proc.new { false } }
  let(:game) { Game.create!(word: 'BUCKET') }

  describe 'PUT /game/1/guess' do
    subject { response }

    render_views

    context 'with valid game, MakeGuess has no errors' do
      let(:mock_make_guess) { instance_double("MakeGuess") }

      before do
        allow(MakeGuess).to receive(:new).and_return(mock_make_guess)
        allow(mock_make_guess).to receive(:call).and_return(true)
        allow(mock_make_guess).to receive(:errors).and_return([])
      end

      it 'calls MakeGuess.new.call' do
        expect(mock_make_guess).to receive(:call).and_return(true)

        put :create, game_id: game.id, letter: 'A'
      end

      it 'redirects to the game with no flash' do
        put :create, game_id: game.id, letter: 'A'

        expect(response).to redirect_to controller: :game, action: :show, id: game.id
      end
    end

    context 'with valid game, MakeGuess has one error' do
      let(:mock_make_guess) { instance_double("MakeGuess") }
      let(:expected_error_message) { "DANGER WILL ROBINSON" }

      before do
        allow(MakeGuess).to receive(:new).and_return(mock_make_guess)
        allow(mock_make_guess).to receive(:call).and_return(false)
        allow(mock_make_guess).to receive(:errors).and_return([expected_error_message])
      end

      it 'calls MakeGuess.new.call' do
        expect(mock_make_guess).to receive(:call).and_return(false)

        put :create, game_id: game.id, letter: 'A'
      end

      it 'redirects to the game with flash' do
        put :create, game_id: game.id, letter: 'A'

        expect(response).to redirect_to controller: :game, action: :show, id: game.id
        expect(flash[:alert]).to eq(expected_error_message)
      end
    end

    context 'with invalid game, valid guess' do
      let(:invalid_game_id) { 99999 }

      it 'explodes with great prejudice' do
        expect { put :create, game_id: invalid_game_id, letter: 'A' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
