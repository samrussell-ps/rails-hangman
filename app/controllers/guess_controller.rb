class GuessController < ApplicationController
  #TODO: this lives in a presenter
  ERROR_MESSAGES = {
    letter_has_been_guessed: "That letter has already been guessed",
    game_does_not_exist: "That game does not exist",
    game_complete: "The game is over!",
    guess_is_invalid: "Whoops, that guess was invalid"
  }

  def create
    if game_exists?
      make_guess
    else
      route_to_game_index
    end
  end

  private

  def make_guess
    #game.make_guess(params[:letter])
    MakeGuess.new(game, params[:letter])
      .on(:guess_created) { route_to_game }
      .on(:guess_not_created) { route_to_game }
      .call
  end

  def game_exists?
    game.present?
  end

  def game
    Game.find_by(params[:game_id])
  end

  def can_we_make_this_guess?
    true
  end

  def show_error
    route_to_game
  end

  def show_game
    route_to_game
  end

  def create_guess
    game.guesses.create(letter: params[:letter])
  end
  
  def route_to_game(alert: nil)
    set_alert_message(alert)

    redirect_to controller: 'game', action: 'show', id: params[:game_id]
  end

  def route_to_game_index
    set_alert_message(:game_does_not_exist)

    redirect_to controller: 'game', action: 'index'
  end

  def set_alert_message(alert)
    flash[:alert] = ERROR_MESSAGES[alert]
  end
end
