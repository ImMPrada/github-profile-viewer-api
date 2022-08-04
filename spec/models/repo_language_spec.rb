require 'rails_helper'

RSpec.describe RepoLanguage, type: :model do
  describe 'associations' do
    it { should belong_to(:repo) }
    it { should belong_to(:language) }
  end
end
