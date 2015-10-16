class BadGuesses
  def initialize(game)
    @game = game
  end

  def call
    #TODO use LetterHasBeenGuessed
    @game.guesses.pluck(:letter).select { |letter| @game.word.exclude?(letter) }
  end
end
