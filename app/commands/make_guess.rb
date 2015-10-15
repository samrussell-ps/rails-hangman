class MakeGuess
  include Shout

  def initialize(game_id, letter)
    @game_id = game_id
    @uppercase_letter = letter.upcase if letter
  end

  def call
    # TODO: do GuessIsInvalid instead
    if !game_exists?
      publish!(:game_does_not_exist)
    elsif !GuessIsValid.new(@uppercase_letter).call
      publish!(:invalid_guess)
    elsif GameComplete.new(game).call
      publish!(:game_complete)
    elsif LetterHasBeenGuessed.new(game, @uppercase_letter).call
      publish!(:letter_has_been_guessed)
    else
      guess = Guess.create!(game: game, letter: @uppercase_letter)
      publish!(:guess_created, guess)
    end
  end

  private

  def game
    Game.find_by(id: @game_id)
  end

  def game_exists?
    !!game
  end
end
