require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:params) { {} }
  subject(:game) { Game.create(params) }

  context "new game" do
    it { is_expected.to respond_to(:word) }

    it { is_expected.to_not be_valid }
  end

  context "game with word in uppercase" do
    let(:params) { { word: 'ABC' } }
    it { is_expected.to respond_to(:word) }

    it { is_expected.to be_valid }
  end

  context "game with word in lowercase" do
    let(:params) { { word: 'abc' } }
    it { is_expected.to respond_to(:word) }

    it { is_expected.to_not be_valid }
  end

  context "game with word in mixed case" do
    let(:params) { { word: 'AbC' } }
    it { is_expected.to respond_to(:word) }

    it { is_expected.to_not be_valid }
  end

  context "game with word with non-alpha characters" do
    let(:params) { { word: 'E%B' } }
    it { is_expected.to respond_to(:word) }

    it { is_expected.to_not be_valid }
  end
end
