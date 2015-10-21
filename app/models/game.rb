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

  # we use the arg "letter" a lot here
  # can we make this betterer?
  # this does need its own object to make shout work
  def make_guess(letter)
    if can_we_guess_this?(letter)
      create_guess(letter)
      publish!(:guess_created)
    else
      publish!(:guess_not_created, why_cant_we_guess_this(letter))
    end
  end

  def over?
    won? || lost?
  end

  def won?
    have_all_the_letters_in_the_word_been_guessed?
  end

  def have_all_the_letters_in_the_word_been_guessed?
    # this feels yuck
    correctly_guessed_letters.uniq.sort == word.chars.uniq.sort
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
end
