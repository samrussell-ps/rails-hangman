class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy

  validates :word, presence: true
  validates :word, format: {
    # TODO: make function for regex
    # use GuessIsValid?
    with: /\A[A-Z]+\Z/,
    message: 'word must be a string of uppercase letters'
  }
end
