class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy

  validates :word, presence: true
  validates :word, format: {
    with: /\A[A-Z]+\Z/,
    message: 'word must be a string of uppercase letters'
  }
end
