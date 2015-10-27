require 'rails_helper'

RSpec.describe GuessLetterValidator do
  describe '#validate' do
    let(:guess) { instance_double('Guess') }
    let(:errors) { instance_double('ActiveModel::Errors') }

    it 'accepts a single uppercase letter' do
      allow(guess).to receive(:letter).and_return('A')
      allow(guess).to receive(:errors).with(no_args).and_return(errors)

      expect(errors).to_not receive(:add)

      GuessLetterValidator.new.validate(guess)
    end

    it 'rejects nil' do
      allow(guess).to receive(:letter).and_return(nil)
      allow(guess).to receive(:errors).with(no_args).and_return(errors)

      expect(errors).to receive(:add).with(:letter, GuessLetterValidator::ERROR_STRING[:must_be_single_upper_alpha])

      GuessLetterValidator.new.validate(guess)
    end

    it 'rejects a single lowercase letter' do
      allow(guess).to receive(:letter).and_return('a')
      allow(guess).to receive(:errors).with(no_args).and_return(errors)

      expect(errors).to receive(:add).with(:letter, GuessLetterValidator::ERROR_STRING[:must_be_single_upper_alpha])

      GuessLetterValidator.new.validate(guess)
    end

    it 'rejects a number' do
      allow(guess).to receive(:letter).and_return('2')
      allow(guess).to receive(:errors).with(no_args).and_return(errors)

      expect(errors).to receive(:add).with(:letter, GuessLetterValidator::ERROR_STRING[:must_be_single_upper_alpha])

      GuessLetterValidator.new.validate(guess)
    end

    it 'rejects a symbol' do
      allow(guess).to receive(:letter).and_return('%')
      allow(guess).to receive(:errors).with(no_args).and_return(errors)

      expect(errors).to receive(:add).with(:letter, GuessLetterValidator::ERROR_STRING[:must_be_single_upper_alpha])

      GuessLetterValidator.new.validate(guess)
    end

    it 'rejects multiple letters' do
      allow(guess).to receive(:letter).and_return('AB')
      allow(guess).to receive(:errors).with(no_args).and_return(errors)

      expect(errors).to receive(:add).with(:letter, GuessLetterValidator::ERROR_STRING[:must_be_single_upper_alpha])

      GuessLetterValidator.new.validate(guess)
    end
  end
end
