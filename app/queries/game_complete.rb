#TODO think about GameStatus
#policy object? Rules?
class GameComplete
  def initialize(game)
    @game = game
  end

  #TODO expose running/finished?, won?, and lost?
  def call
    game_finished?
  end

  def result
    return :running unless game_finished?

    if game_won?
      :won
    else
      :lost
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
