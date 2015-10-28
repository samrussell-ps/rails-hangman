class Word < ActiveRecord::Base
  validates_with GameWordValidator

  has_many :games
end
