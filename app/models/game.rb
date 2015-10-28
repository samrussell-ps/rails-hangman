class Game < ActiveRecord::Base
  INITIAL_NUMBER_OF_LIVES = 9

  has_many :guesses, dependent: :destroy
  belongs_to :word

  validates :word, presence: true

  scope :first_five_games, -> {
    order(created_at: :desc).limit(5)
  }

  def over?
    won? || lost?
  end

  def won?
    have_all_the_letters_in_the_word_been_guessed?
  end

  def have_all_the_letters_in_the_word_been_guessed?
    unique_characters_in_word_to_be_guessed = word_to_guess.chars.uniq

    unique_characters_in_word_to_be_guessed.all? do |character|
      correctly_guessed_letters.include?(character)
    end
  end

  def lost?
    lives_left == 0
  end

  def lives_left
    INITIAL_NUMBER_OF_LIVES - incorrectly_guessed_letters.size
  end

  def correctly_guessed_letters
    guessed_letters.select { |letter| word_to_guess.include?(letter) }
  end

  def incorrectly_guessed_letters
    guessed_letters.select { |letter| word_to_guess.exclude?(letter) }
  end

  def have_we_guessed?(letter)
    guessed_letters.include?(letter)
  end

  def guessed_letters
    guesses.pluck('letter')
  end

  def is_guess_valid?(letter)
    letter.match(/\A[A-Z]\z/).present?
  end

  def create_guess(letter)
    guesses.create!(letter: letter)
  end

  def word_to_guess
    word.word
  end
end
