require 'rails_helper'

RSpec.describe Repo, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:profile) }
    it { is_expected.to have_many(:repo_languages) }
    it { is_expected.to have_many(:languages) }
  end

  describe 'validations' do
    subject(:repo) { create(:repo) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:languages_url) }
    it { is_expected.to validate_presence_of(:git_date) }
  end
end
