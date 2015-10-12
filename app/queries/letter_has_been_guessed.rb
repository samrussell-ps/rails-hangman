class LetterHasBeenGuessed
  def initialize(game, letter)
    @game = game
    @letter = letter
  end

  def call
    @game.guesses.any?{ |guess| guess.letter == @letter }
  end
end

