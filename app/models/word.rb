class Word < ActiveRecord::Base
  validates_with GameWordValidator
end
