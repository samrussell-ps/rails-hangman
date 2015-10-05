class GuessController < ApplicationController
  def create
    guess = Guess.new(params[:guess].permit(:hangman_id, :letter))
    guess.save
    redirect_to(guess.hangman)
  end
end
