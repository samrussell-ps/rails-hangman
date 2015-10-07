require 'rails_helper'

RSpec.describe ChooseRandomWord do
  subject(:choose_random_word) { ChooseRandomWord.instance }

  describe '#next_word' do
    subject(:next_word) { choose_random_word.next_word }

    it { is_expected.to match(/\A[[:alpha:]]+\Z/) }
  end
end
