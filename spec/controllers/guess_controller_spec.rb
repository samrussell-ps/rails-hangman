require 'rails_helper'

RSpec.describe GuessController, type: :controller do
  describe 'PUT /game/1/guess' do
    subject { response }

    render_views

    context 'with game_id = 1' do
      # bad params
      # it should display an error somehow?
      before do
        put :create, game_id: 1 # stuff
      end

      it { is_expected.to redirect_to controller: :game, action: :show, id: 1 }
    end

    context 'with game_id = 1, letter = "A"' do
      Game.create!(word: 'BUCKET')
      before do
        put :create, game_id: 1, letter: 'A'
      end

      it 'makes a new guess' do
        expect {
          put :create, game_id: 1, letter: 'E'
        }.to change(Guess, :count).by(1)
      end

      it { is_expected.to redirect_to controller: :game, action: :show, id: 1 }
    end
  end
end
