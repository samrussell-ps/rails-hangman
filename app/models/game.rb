class Game < ActiveRecord::Base
  INITIAL_NUMBER_OF_LIVES = 9

  include Shout

  has_many :guesses, dependent: :destroy

  validates :word, presence: true
  validates :word, format: {
    # TODO: make function for regex
    # use GuessIsValid?
    with: /\A[A-Z]+\Z/,
    message: 'word must be a string of uppercase letters'
  }

  def over?
    won? || lost?
  end

  def won?
    have_all_the_letters_in_the_word_been_guessed?
  end

  def have_all_the_letters_in_the_word_been_guessed?
    unique_characters_in_word_to_be_guessed = word.chars.uniq.sort

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
    guessed_letters.select { |letter| word.include?(letter) }
  end

  def incorrectly_guessed_letters
    guessed_letters.select { |letter| word.exclude?(letter) }
  end

  def have_we_guessed?(letter)
    guessed_letters.include?(letter)
  end

  def guessed_letters
    guesses.pluck('letter')
  end

  def is_guess_valid?(letter)
    letter.match(/\A[A-Z]\Z/).present?
  end

  def create_guess(letter)
    guesses.create!(letter: letter)
  end

  def self.first_five_games
    order(id: :desc).limit(5)
  end
end
