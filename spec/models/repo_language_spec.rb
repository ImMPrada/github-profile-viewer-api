require 'rails_helper'

RSpec.describe RepoLanguage, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:repo) }
    it { is_expected.to belong_to(:language) }
  end
end
