class GamePresenter
  def initialize(game)
    @game = game
  end

  def word_progress
    @game.word.chars.map { |char|
      @game.correctly_guessed_letters.include?(char) ? char : '_'
    }
    .join(' ')
  end

  def incorrect_guesses
    @game.incorrectly_guessed_letters.join(' ')
  end

  def lives_left
    @game.lives_left
  end

  def game_over?
    @game.over?
  end

  def game_won?
    @game.won?
  end

  def game_lost?
    @game.lost?
  end

  def word
    @game.word
  end
end
