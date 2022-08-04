require 'rails_helper'

RSpec.describe Repo, type: :model do
  describe 'associations' do
    it { should belong_to(:profile) }
    it { should have_many(:repo_languages) }
    it { should have_many(:languages) }
  end
end
