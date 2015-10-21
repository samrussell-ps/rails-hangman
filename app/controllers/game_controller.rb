class GameController < ApplicationController
  before_filter :navbar

  def show
    redirect_to controller: 'game', action: 'index' unless game

    @presenter = GamePresenter.new(game)
  end

  def game
    @game = Game.find_by(id: game_id)
  end

  def game_id
    params[:id]
  end

  def index
    @games = Game.all
  end

  def new
  end

  def create
    new_game = MakeGame.new.call

    redirect_to new_game
  end

  private 

  def navbar
    # TODO make a scope on Game
    @first_five_games = Game.order(id: :desc).limit(5)
  end
end
