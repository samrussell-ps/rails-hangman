require 'rails_helper'

RSpec.describe GameController, type: :controller do
  let(:game_controller) { GameController.new }

  describe 'GET /game/1' do
    subject { response }

    render_views

    before do
      get :show, id: 1
    end

    it { is_expected.to render_template(:show) }
  end

  describe 'GET /game/new' do
    subject { response }

    render_views

    before do
      get :new
    end

    it { is_expected.to render_template(:new) }
  end

  describe 'POST /game' do
    subject { response }

    render_views

    before do
      post :create # stuff
    end

    it { is_expected.to redirect_to action: :show, id: Game.all[-1].id }
  end
end
