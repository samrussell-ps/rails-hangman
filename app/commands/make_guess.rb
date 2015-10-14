class MakeGuess
  def initialize(game, letter)
    @game = game
    @letter = letter
  end

  def call
    # TODO fail when game is over
    uppercase_letter = @letter.upcase if @letter
    if GameComplete.new(@game).call || LetterHasBeenGuessed.new(@game, uppercase_letter).call
      return false
    end
    # TODO use shout
    # TODO test for exception with create! instead
    # this shouldn't be called so error makes more sense
    # @game.guesses.build ....
    Guess.create!(game: @game, letter: uppercase_letter)
  end
end
