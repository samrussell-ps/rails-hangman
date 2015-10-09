require 'rails_helper'

RSpec.describe WordProgress do
  let(:game) { Game.create!(word: 'WORD') }
  let(:word_progress) { WordProgress.new(game) }
  subject { word_progress.call }

  it { is_expected.to be_a_kind_of(Array) }

  context 'with a new game with no bad guesses' do
    it { is_expected.to eq([nil, nil, nil, nil]) }
  end

  context 'with a new game with one bad guess' do
    before do
      ['A'].each { |letter| game.guesses.create!(letter: letter) }
    end

    it { is_expected.to eq([nil, nil, nil, nil]) }
  end

  context 'with a new game with one correct guess' do
    before do
      ['O'].each { |letter| game.guesses.create!(letter: letter) }
    end

    it { is_expected.to eq([nil, 'O', nil, nil]) }
  end
end