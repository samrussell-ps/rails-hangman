class GameComplete
  def initialize(game)
    @game = game
  end

  def call
    { finished: game_finished?,
      status: game_status }
  end

  private

  def game_status
    game_won? ? :won : :lost if game_finished?
  end

  def game_finished?
    game_won? || game_lost?
  end

  def game_won?
    !WordProgress.new(@game).call.include?(nil)
  end

  def game_lost?
    LivesLeft.new(@game).call == 0
  end
end
