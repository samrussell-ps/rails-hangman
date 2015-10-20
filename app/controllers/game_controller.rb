class GameController < ApplicationController
  before_filter :navbar

  def show
    # TODO: put this somewhere else
    # TODO: this explodes if game doesn't exist
    @game = Game.find(params[:id])
    # TODO very not DRY, find a nicer way to do this
    @word_progress = WordProgress.new(@game).call
    @bad_guesses = BadGuesses.new(@game).call
    @lives_left = LivesLeft.new(@game).call
    @game_status = GameComplete.new(@game).result
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
