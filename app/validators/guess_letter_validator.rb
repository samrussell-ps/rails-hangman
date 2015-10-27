class GuessLetterValidator < ActiveModel::Validator
  ERROR_STRING = {
    must_be_single_upper_alpha: "must be a single uppercase letter",
  }

  def validate(record)
    must_be_single_upper_alpha(record)
  end

  private

  def must_be_single_upper_alpha(record)
    if record.letter.nil? || record.letter.match(/\A[A-Z]\z/).nil?
      record.errors.add :letter, ERROR_STRING[:must_be_single_upper_alpha]
    end
  end
end
