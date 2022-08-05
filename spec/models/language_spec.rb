require 'rails_helper'

RSpec.describe Language, type: :model do
  describe 'associations' do
    it { should have_many(:repo_languages) }
    it { should have_many(:repos) }
    it { should have_many(:profile_languages) }
    it { should have_many(:profiles) }
  end

  describe 'validations' do
    subject(:language) { create(:language) }
    subject(:language_duplicate) { create(:language) }

    it 'should be valid' do
      expect(language).to be_valid
    end
    it 'should not be valid with blank or null name' do
      language.name = nil
      expect(language).not_to be_valid
    end
    it 'should not be valid with blank or null amount' do
      language.amount = nil
      expect(language).not_to be_valid
    end
    it 'should not be valid if name is already takken' do
      language_duplicate.name = language.name
      expect(language_duplicate).not_to be_valid
    end
    it 'should not be case sensitive, at name uniqueness validation' do
      language_duplicate.name = language.name.downcase
      expect(language_duplicate).not_to be_valid
    end
  end
end
