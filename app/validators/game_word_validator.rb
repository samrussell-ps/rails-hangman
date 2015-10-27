class GameWordValidator < ActiveModel::Validator
  ERROR_STRING = {
    must_be_upper_alpha: "must be uppercase letters",
  }

  def validate(record)
    must_be_upper_alpha(record)
  end

  private

  def must_be_upper_alpha(record)
    if record.word.nil? || record.word.match(/\A[A-Z]+\z/).nil?
      record.errors.add :word, ERROR_STRING[:must_be_upper_alpha]
    end
  end
end

