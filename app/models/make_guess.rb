class MakeGuess
  def initialize(game, letter)
    @game = game
    @letter = letter
  end

  def call
    uppercase_letter = @letter.upcase
    Guess.new( { game: @game, letter: uppercase_letter } ).save
  end
end
