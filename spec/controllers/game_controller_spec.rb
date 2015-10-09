require 'rails_helper'

RSpec.describe GameController, type: :controller do
  let(:game_controller) { GameController.new }

  # GET /game
  describe '#index' do
    subject { response }

    render_views

    before do
      get :index
    end

    it { is_expected.to render_template(:index) }
  end

  # GET /game/1
  describe '#show' do
    subject { response }

    render_views

    before do
      get :show, id: 1
    end

    it { is_expected.to render_template(:show) }
  end

  # GET /game/new
  describe '#new' do
    subject { response }

    render_views

    before do
      get :new
    end

    it { is_expected.to render_template(:new) }
  end

  # POST /game
  describe '#create' do
    subject { response }

    render_views

    it 'creates a new game' do
      expect { post :create }.to change{ Game.count }.by(1)
    end

    context 'with the new game' do
      before do
        post :create # stuff
      end

      it { is_expected.to redirect_to action: :show, id: Game.all[-1].id }
    end
  end
end
