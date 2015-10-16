class LetterHasBeenGuessed
  def initialize(game, letter)
    @game = game
    @letter = letter
  end

  def call
    @game.guesses.pluck(:letter).include? @letter
  end
end
