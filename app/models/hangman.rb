class Hangman < ActiveRecord::Base
  INITIAL_LIVES_COUNT = 9

  has_many :guesses

  validates :word, presence: true

  def word_progress
    self.word.chars.map do |letter|
      letter if guessed_letters.include?(letter)
    end
  end

  def lives_left
    INITIAL_LIVES_COUNT - incorrect_guesses.size
  end

  def guessed_letters
    @guessed_letters ||= self.guesses.map { |guess| guess.letter }
  end

  def incorrect_guesses
    guessed_letters.each_with_object([]) do |letter, incorrect_guesses|
      incorrect_guesses << letter unless word.chars.include? letter
    end
  end
end
