class GameController < ApplicationController
  before_filter :navbar

  def show
    @active_page = ActivePage.new(:resume)
    @game = Game.find(params[:id])
    # TODO very not DRY, find a nicer way to do this
    @word_progress = WordProgress.new(@game).call
    @bad_guesses = BadGuesses.new(@game).call
    @lives_left = LivesLeft.new(@game).call
  end

  def index
    @games = Game.all
    @active_page = ActivePage.new(:home)
  end

  def new
    # this is an HTML form to create the new object
    # @game = Game.new
  end

  def create
    # tell it to do a redirect or render
    # if no error
    # redirect_to @game
    # else
    # render :new *this will re-render if there are issues*
    # end
    redirect_to MakeGame.new.call
  end

  private 

  def navbar
    @active_page = ActivePage.new()
    @first_five_games = Game.order(id: :desc).limit(5)
  end
end
