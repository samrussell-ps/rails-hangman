class MakeGuess
  def initialize(game, letter)
    @game = game
    @letter = letter
  end

  def call
    uppercase_letter = @letter.upcase
    # TODO test for exception with create! instead
    Guess.new( { game: @game, letter: uppercase_letter } ).save
  end
end
