class MakeGuess
  def initialize(game, letter)
    @game = game
    @letter = letter
  end

  def call
    # TODO fail when game is over
    # heavy line, lot of moving parts
    # result = GameComplete....call = true/false
    # result.status = :won or :lost
    # worrying that we discard part of the return - it means it does 2 things
    uppercase_letter = @letter.upcase if @letter
    unless GameComplete.new(@game).call or LetterHasBeenGuessed.new(@game, uppercase_letter).call
      # TODO test for exception with create! instead
      # this shouldn't be called so error makes more sense
      # @game.guesses.build ....
      Guess.new(game: @game, letter: uppercase_letter).save
    else
      false
    end
  end
end
