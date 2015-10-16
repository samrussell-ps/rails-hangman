class Guess < ActiveRecord::Base
  belongs_to :game

  validates :game, presence: true
  validates :letter, format: {
    # TODO: make function for regex
    # use GuessIsValid?
    with: /\A[A-Z]\Z/,
    message: 'letter must be a single uppercase letter'
  }
end
