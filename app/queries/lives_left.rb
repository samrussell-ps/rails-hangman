class LivesLeft
  # maybe stick this in the Game model?
  INITIAL_LIVES = 9

  def initialize(game)
    @game = game
  end

  def call
    bad_guesses_count = BadGuesses.new(@game).call.size
    INITIAL_LIVES - bad_guesses_count
  end
end
