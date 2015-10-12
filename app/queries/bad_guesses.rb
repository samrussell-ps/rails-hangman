class BadGuesses
  def initialize(game)
    @game = game
  end

  def call
    @game.guesses.map{ |guess| guess.letter if @game.word.exclude?(guess.letter) }.compact
  end
end
