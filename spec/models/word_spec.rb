require 'rails_helper'

RSpec.describe Word, type: :model do
  let(:params) { {} }
  subject(:word) { Word.create(params) }

  context "in uppercase" do
    let(:params) { { word: 'ABC' } }

    it { is_expected.to be_valid }
  end

  context "in lowercase" do
    let(:params) { { word: 'abc' } }

    it { is_expected.to_not be_valid }
  end

  context "in mixed case" do
    let(:params) { { word: 'AbC' } }

    it { is_expected.to_not be_valid }
  end

  context "with non-alpha characters" do
    let(:params) { { word: 'E%B' } }

    it { is_expected.to_not be_valid }
  end
end
