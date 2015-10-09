class MakeGuess
  def initialize(game, letter)
    @game = game
    @letter = letter
  end

  def call
    # TODO fail when game is over
    unless GameComplete.new(@game).call[:finished]
      uppercase_letter = @letter.upcase
      # TODO test for exception with create! instead
      Guess.new( { game: @game, letter: uppercase_letter } ).save
    else
      false
    end
  end
end
