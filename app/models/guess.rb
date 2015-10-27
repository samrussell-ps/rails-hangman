class Guess < ActiveRecord::Base
  belongs_to :game

  validates :game, presence: true
  validates_with GuessLetterValidator
end
