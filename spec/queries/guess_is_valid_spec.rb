require 'rails_helper'

RSpec.describe GuessIsValid do
  let(:guess) { nil }
  let(:guess_is_valid) { GuessIsValid.new(guess) }

  describe '#call' do
    subject(:call) { guess_is_valid.call }

    context 'with nil' do
      let(:guess) { nil }

      it { is_expected.to be false }
    end

    context 'with an uppercase letter' do
      let(:guess) { 'A' }

      it { is_expected.to be true }
    end

    context 'with a lowercase letter' do
      let(:guess) { 'a' }

      it { is_expected.to be false }
    end

    context 'with multiple characters' do
      let(:guess) { 'abc' }

      it { is_expected.to be false }
    end

    context 'with a number' do
      let(:guess) { '2' }

      it { is_expected.to be false }
    end

    context 'with a symbol' do
      let(:guess) { '%' }
      
      it { is_expected.to be false }
    end
  end
end
