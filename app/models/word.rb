class Word < ActiveRecord::Base
  validates_with GameWordValidator

  has_and_belongs_to_many :games
end
