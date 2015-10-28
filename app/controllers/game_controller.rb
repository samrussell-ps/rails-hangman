class GameController < ApplicationController
  def show
    redirect_to controller: 'game', action: 'index' unless game

    @presenter = GamePresenter.new(game)
  end

  def game
    @game = Game.find_by(id: game_id)
  end

  def index
    @games = Game.all
  end

  def new
  end

  def create
    new_game = CreateGame.new.call

    redirect_to new_game
  end

  private

  def game_id
    params[:id]
  end
end
