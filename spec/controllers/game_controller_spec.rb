require 'rails_helper'

RSpec.describe GameController, type: :controller do
  let(:game_controller) { GameController.new }
  let(:game) { Game.create!(word: Word.create!(word: 'BUCKET')) }

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
    let(:id_of_game_that_does_not_exist) { 99999 }

    render_views

    it 'shows game when game exists' do
      get :show, id: game.id

      expect(response).to render_template(:show)
    end

    it 'redirects to index when game does not exist' do
      get :show, id: id_of_game_that_does_not_exist

      expect(response).to redirect_to controller: :game, action: :index
    end
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
