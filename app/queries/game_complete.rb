class GameComplete
  def initialize(game)
    @game = game
  end

  def call
    game_finished?
  end

  def result
    if game_finished?
      game_won? ? :won : :lost
    else
      :running
    end
  end

  private

  def game_finished?
    game_won? || game_lost?
  end

  def game_won?
    WordProgress.new(@game).call.exclude?(nil)
  end

  def game_lost?
    LivesLeft.new(@game).call == 0
  end
end
