class GameController < ApplicationController
  before_filter :navbar

  def show
    # TODO: put this somewhere else
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
    redirect_to MakeGame.new.call
  end

  private 

  def navbar
    @first_five_games = Game.order(id: :desc).limit(5)
  end
end
