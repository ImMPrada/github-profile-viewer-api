require 'rails_helper'

RSpec.describe Language, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:repo_languages) }
    it { is_expected.to have_many(:repos) }
    it { is_expected.to have_many(:profile_languages) }
    it { is_expected.to have_many(:profiles) }
  end

  describe 'validations' do
    subject(:language) { build(:language) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:amount) }
  end

  describe 'valid with amount = 0' do
    subject(:language) { build(:language, amount: 0) }

    it { expect(language).to be_valid }
  end

  describe 'valid with null amount' do
    subject(:language) { build(:language, amount: nil) }

    it { expect(language).not_to be_valid }
  end
end
