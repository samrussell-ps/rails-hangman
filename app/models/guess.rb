class Guess < ActiveRecord::Base
  belongs_to :hangman

  validates :hangman, presence: true
  validates :letter, uniqueness: { scope: :hangman }
end
