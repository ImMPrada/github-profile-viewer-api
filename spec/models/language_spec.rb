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

  describe '.amounts_by_language' do
    let(:amount_by_languages_expcted_result) do
      {
        'Ruby' => 10,
        'Python' => 20,
        'JavaScript' => 30,
        'HTML' => 40
      }
    end

    before do
      create(:language, name: 'Ruby', amount: 10)
      create(:language, name: 'Python', amount: 5)
      create(:language, name: 'JavaScript', amount: 10)
      create(:language, name: 'HTML', amount: 20)
      create(:language, name: 'JavaScript', amount: 20)
      create(:language, name: 'HTML', amount: 20)
      create(:language, name: 'Python', amount: 15)
    end

    it 'returns a hash of languages and amounts' do
      expect(described_class.all.amounts_by_language).to eq(amount_by_languages_expcted_result)
    end
  end

  describe '.total_amount' do
    let(:total_amount_expcted_result) { 30 }

    before do
      create(:language, name: 'Ruby', amount: 10)
      create(:language, name: 'Python', amount: 5)
      create(:language, name: 'Python', amount: 15)
    end

    it 'returns the total amount of languages' do
      expect(described_class.all.total_amount).to eq(total_amount_expcted_result)
    end
  end

  describe '.weights_by_language' do
    let(:weights_by_language_expcted_result) do
      {
        'Ruby' => 0.1,
        'Python' => 0.2,
        'JavaScript' => 0.3,
        'HTML' => 0.4
      }
    end

    before do
      create(:language, name: 'Ruby', amount: 10)
      create(:language, name: 'Python', amount: 5)
      create(:language, name: 'JavaScript', amount: 10)
      create(:language, name: 'HTML', amount: 20)
      create(:language, name: 'JavaScript', amount: 20)
      create(:language, name: 'HTML', amount: 20)
      create(:language, name: 'Python', amount: 15)
    end

    it 'returns a hash of languages and weights' do
      expect(described_class.all.weights_by_language).to eq(weights_by_language_expcted_result)
    end
  end
end
