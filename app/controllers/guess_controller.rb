class GuessController < ApplicationController
  #TODO: this lives in a presenter
  ERROR_MESSAGES = {
    letter_has_been_guessed: "That letter has already been guessed",
    game_does_not_exist: "That game does not exist",
    game_complete: "The game is over!",
    guess_is_invalid: "Whoops, that guess was invalid"
  }

  def create
    #TODO unhide route_to_game_index
    MakeGuess.new(params[:game_id], params[:letter])
      .on(:game_does_not_exist) { route_to_game_index(alert: :game_does_not_exist) }
      .on(:letter_has_been_guessed) { route_to_game(alert: :letter_has_been_guessed) }
      .on(:game_complete) { route_to_game(alert: :game_complete) }
      .on(:guess_is_invalid) { route_to_game(alert: :guess_is_invalid) }
      .on(:guess_created) { route_to_game }
      .call
  end

  private
  
  def route_to_game(alert: nil)
    set_alert_message(alert)

    redirect_to controller: 'game', action: 'show', id: params[:game_id]
  end

  def route_to_game_index(alert: nil)
    set_alert_message(alert)

    redirect_to controller: 'game', action: 'index'
  end

  def set_alert_message(alert)
    #TODO ERROR_MESSAGES.fetch(alert, nil)
    flash[:alert] = ERROR_MESSAGES[alert] if alert
  end
end
