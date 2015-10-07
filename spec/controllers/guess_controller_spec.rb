require 'rails_helper'

RSpec.describe GuessController, type: :controller do
  describe 'GET /game/1/guess/create' do
    subject { response }

    render_views

    before do
      put :create, game_id: 1 # stuff
    end

    it { is_expected.to redirect_to controller: :game, action: :show, id: 1 }
  end
end
