class GamePresenter < SimpleDelegator
  def word_progress
    word_to_guess.chars.map { |char|
      correctly_guessed_letters.include?(char) ? char : '_'
    }
    .join(' ')
  end

  def incorrect_guesses
    incorrectly_guessed_letters.join(' ')
  end
end
