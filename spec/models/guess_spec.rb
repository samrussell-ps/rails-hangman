require 'rails_helper'

RSpec.describe Guess, type: :model do
  let(:params) { {} }
  let(:game) { Game.create }
  subject(:guess) { Guess.create(params) }

  context 'new guess' do
    it { is_expected.to_not be_valid }
  end

  context 'guess with uppercase letter' do
    let(:params) { { letter: 'A' } }

    it { is_expected.to_not be_valid }
  end

  context 'guess with game' do
    let(:params) { { game: game } }

    it { is_expected.to_not be_valid }
  end

  context 'guess with uppercase letter and game' do
    let(:params) { { letter: 'A', game: game } }

    it { is_expected.to be_valid }
  end

  context 'guess with lowercase letter and game' do
    let(:params) { { letter: 'a', game: game } }

    it { is_expected.to_not be_valid }
  end

  context 'guess with two uppercase letters and game' do
    let(:params) { { letter: 'AE', game: game } }

    it { is_expected.to_not be_valid }
  end

  context 'guess with an invalid character and game' do
    let(:params) { { letter: '%', game: game } }

    it { is_expected.to_not be_valid }
  end
end
