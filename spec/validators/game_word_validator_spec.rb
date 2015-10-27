require 'rails_helper'

RSpec.describe GameWordValidator do
  describe '#validate' do
    let(:game) { instance_double('Game') }
    let(:errors) { instance_double('ActiveModel::Errors') }

    it 'accepts a single uppercase letter' do
      allow(game).to receive(:word).and_return('A')
      allow(game).to receive(:errors).with(no_args).and_return(errors)

      expect(errors).to_not receive(:add)

      GameWordValidator.new.validate(game)
    end

    it 'accepts multiple letters' do
      allow(game).to receive(:word).and_return('AB')
      allow(game).to receive(:errors).with(no_args).and_return(errors)

      expect(errors).to_not receive(:add)

      GameWordValidator.new.validate(game)
    end

    it 'rejects nil' do
      allow(game).to receive(:word).and_return(nil)
      allow(game).to receive(:errors).with(no_args).and_return(errors)

      expect(errors).to receive(:add).with(:word, GameWordValidator::ERROR_STRING[:must_be_upper_alpha])

      GameWordValidator.new.validate(game)
    end

    it 'rejects a single lowercase letter' do
      allow(game).to receive(:word).and_return('a')
      allow(game).to receive(:errors).with(no_args).and_return(errors)

      expect(errors).to receive(:add).with(:word, GameWordValidator::ERROR_STRING[:must_be_upper_alpha])

      GameWordValidator.new.validate(game)
    end

    it 'rejects a number' do
      allow(game).to receive(:word).and_return('2')
      allow(game).to receive(:errors).with(no_args).and_return(errors)

      expect(errors).to receive(:add).with(:word, GameWordValidator::ERROR_STRING[:must_be_upper_alpha])

      GameWordValidator.new.validate(game)
    end

    it 'rejects a symbol' do
      allow(game).to receive(:word).and_return('%')
      allow(game).to receive(:errors).with(no_args).and_return(errors)

      expect(errors).to receive(:add).with(:word, GameWordValidator::ERROR_STRING[:must_be_upper_alpha])

      GameWordValidator.new.validate(game)
    end
  end
end

