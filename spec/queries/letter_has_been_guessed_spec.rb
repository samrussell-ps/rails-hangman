require 'rails_helper'

RSpec.describe LetterHasBeenGuessed do
  let(:letter) { nil }
  let(:game) { Game.create!(word: 'WORD') }
  let(:letter_has_been_guessed) { LetterHasBeenGuessed.new(game, letter) }
  subject { letter_has_been_guessed.call }

  it { is_expected.to be_a_kind_of(TrueClass).or be_a_kind_of(FalseClass) }

  context 'unguessed correct letter' do
    let(:letter) { 'O' }
    
    it { is_expected.to be false }
  end

  context 'guessed correct letter' do
    let(:letter) { 'O' }

    before do
      # TODO refactor, doesn't need .each
      # TODO: use :letter
      ['O'].each { |letter| game.guesses.create!(letter: letter) }
    end
    
    it { is_expected.to be true }
  end

  context 'unguessed incorrect letter' do
    let(:letter) { 'A' }
    
    it { is_expected.to be false }
  end

  context 'guessed correct letter' do
    let(:letter) { 'A' }

    before do
      ['A'].each { |letter| game.guesses.create!(letter: letter) }
    end
    
    it { is_expected.to be true }
  end
end
