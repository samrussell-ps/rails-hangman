class HangmanController < ApplicationController
  def new
    hangman = Hangman.new(word: 'TREE')
    hangman.save
    redirect_to(hangman)
  end

  def show
    @hangman = Hangman.find(params[:id]) || render(status: 404) && return
  end
end
