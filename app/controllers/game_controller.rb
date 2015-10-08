class GameController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def show
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
    redirect_to Game.create!( {word: 'WAT'} )
  end
end
