require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:repos) }
    it { is_expected.to have_many(:profile_languages) }
    it { is_expected.to have_many(:languages) }
  end

  describe 'validations' do
    subject(:profile) { build(:profile) }

    before do
      create_list(:repo, 4, profile: profile)
    end

    it { is_expected.to validate_presence_of(:nickname) }
    it { is_expected.to validate_presence_of(:avatar) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:public_repos_count) }
    it { is_expected.to validate_presence_of(:public_gists_count) }
    it { is_expected.to validate_presence_of(:followers_count) }
    it { is_expected.to validate_presence_of(:followings_count) }
    it { is_expected.to validate_presence_of(:git_date) }
    it { expect(profile.repos.size).to eq(4) }
  end

  describe 'validate: counts can be 0' do
    subject(:profile) { build(:profile) }

    before do
      profile.public_repos_count = 0
      profile.public_gists_count = 0
      profile.followers_count = 0
      profile.followings_count = 0
      profile.save
    end

    it { is_expected.to be_valid }
  end

  describe 'validate: counts can\'t be null' do
    subject(:profile) { build(:profile, followings_count: nil) }

    it { is_expected.not_to be_valid }
  end

  describe 'a nickname allready registered, can\'t be saved, and is no case sensitive' do
    let(:profile) { create(:profile) }
    let(:profile2) { build(:profile, nickname: profile.nickname) }
    let(:profile3) { build(:profile, nickname: profile.nickname.upcase) }

    it { expect(profile2).not_to be_valid }
    it { expect(profile3).not_to be_valid }
  end
end
