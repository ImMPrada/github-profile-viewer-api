require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'associations' do
    it { should belong_to(:location) }
    it { should have_many(:repos) }
    it { should have_many(:profile_languages) }
    it { should have_many(:languages) }
  end
end
