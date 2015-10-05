class Hangman < ActiveRecord::Base
  has_many :guesses

  validates :word, presence: true
end
