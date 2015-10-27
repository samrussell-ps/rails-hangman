require 'rails_helper'

RSpec.describe ChooseRandomWord do
  subject(:choose_random_word) { ChooseRandomWord.new }

  describe '#next_word' do
    subject(:next_word) { choose_random_word.next_word.word }

    # TODO test for randomness

    # TODO reuse this in Word validator
    it { is_expected.to match(/\A[[:alpha:]]+\Z/) }
  end
end
