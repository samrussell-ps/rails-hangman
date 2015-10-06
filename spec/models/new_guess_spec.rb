require 'rails_helper'

RSpec.describe NewGuess do
  let(:letter) { nil }
  let(:game) { Game.create!(word: 'TELEPHONE') }
  let(:new_guess) { NewGuess.new(game, letter) }

  describe '#call' do
    subject { new_guess.call }

    context 'with an uppercase letter' do
      let(:letter) { 'A' }

      it { is_expected.to be true }
    end

    context 'with a lowercase letter' do
      let(:letter) { 'a' }

      it { is_expected.to be true }
    end

    context 'with multiple characters' do
      let(:letter) { 'abc' }

      it { is_expected.to be false }
    end

    context 'with a number' do
      let(:letter) { '2' }

      it { is_expected.to be false }
    end

    context 'with a symbol' do
      let(:letter) { '%' }

      it { is_expected.to be false }
    end
  end
end
