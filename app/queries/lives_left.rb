class LivesLeft
  def initialize(game)
    @game = game
  end

  def call
    # BadGuesses should be BadGuessesCount? CountBadGuesses?
    bad_guesses_count = BadGuesses.new(@game).call
    9 - bad_guesses_count
  end
end
