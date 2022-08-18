require 'rails_helper'

RSpec.describe Github::ReposConsumer do
  let(:repos_consumer) { described_class.new('immprada') }

  describe 'when the profile exists on github, ApiClient code: 200' do
    let(:expected_response) do
      [
        {
          name: 'art_musseum',
          url: 'https://github.com/ImMPrada/art_musseum',
          description: nil,
          git_date: '2022-08-02T19:09:18Z',
          is_active: true
        }
      ]
    end

    before do
      repos_response = instance_double(
        Github::ApiClient,
        fetch_profile_repos: {},
        code: 200,
        body:
          [
            {
              'id' => 520_181_116,
              'node_id' => 'R_kgDOHwFVfA',
              'name' => 'art_musseum',
              'full_name' => 'ImMPrada/art_musseum',
              'private' => false,
              'owner' => {
                'login' => 'ImMPrada',
                'id' => 26_731_448,
                'node_id' => 'MDQ6VXNlcjI2NzMxNDQ4',
                'avatar_url' => 'https://avatars.githubusercontent.com/u/26731448?v=4',
                'gravatar_id' => '',
                'url' => 'https://api.github.com/users/ImMPrada',
                'html_url' => 'https://github.com/ImMPrada',
                'followers_url' => 'https://api.github.com/users/ImMPrada/followers',
                'following_url' => 'https://api.github.com/users/ImMPrada/following{/other_user}',
                'gists_url' => 'https://api.github.com/users/ImMPrada/gists{/gist_id}',
                'starred_url' => 'https://api.github.com/users/ImMPrada/starred{/owner}{/repo}',
                'subscriptions_url' => 'https://api.github.com/users/ImMPrada/subscriptions',
                'organizations_url' => 'https://api.github.com/users/ImMPrada/orgs',
                'repos_url' => 'https://api.github.com/users/ImMPrada/repos',
                'events_url' => 'https://api.github.com/users/ImMPrada/events{/privacy}',
                'received_events_url' => 'https://api.github.com/users/ImMPrada/received_events',
                'type' => 'User',
                'site_admin' => false
              },
              'html_url' => 'https://github.com/ImMPrada/art_musseum',
              'description' => nil,
              'fork' => false,
              'url' => 'https://api.github.com/repos/ImMPrada/art_musseum',
              'forks_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/forks',
              'keys_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/keys{/key_id}',
              'collaborators_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/collaborators{/collaborator}',
              'teams_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/teams',
              'hooks_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/hooks',
              'issue_events_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/issues/events{/number}',
              'events_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/events',
              'assignees_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/assignees{/user}',
              'branches_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/branches{/branch}',
              'tags_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/tags',
              'blobs_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/git/blobs{/sha}',
              'git_tags_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/git/tags{/sha}',
              'git_refs_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/git/refs{/sha}',
              'trees_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/git/trees{/sha}',
              'statuses_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/statuses/{sha}',
              'languages_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/languages',
              'stargazers_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/stargazers',
              'contributors_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/contributors',
              'subscribers_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/subscribers',
              'subscription_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/subscription',
              'commits_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/commits{/sha}',
              'git_commits_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/git/commits{/sha}',
              'comments_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/comments{/number}',
              'issue_comment_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/issues/comments{/number}',
              'contents_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/contents/{+path}',
              'compare_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/compare/{base}...{head}',
              'merges_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/merges',
              'archive_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/{archive_format}{/ref}',
              'downloads_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/downloads',
              'issues_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/issues{/number}',
              'pulls_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/pulls{/number}',
              'milestones_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/milestones{/number}',
              'notifications_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/notifications{?since,all,participating}',
              'labels_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/labels{/name}',
              'releases_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/releases{/id}',
              'deployments_url' => 'https://api.github.com/repos/ImMPrada/art_musseum/deployments',
              'created_at' => '2022-08-01T16:19:11Z',
              'updated_at' => '2022-08-02T19:09:18Z',
              'pushed_at' => '2022-08-02T23:46:13Z',
              'git_url' => 'git://github.com/ImMPrada/art_musseum.git',
              'ssh_url' => 'git@github.com:ImMPrada/art_musseum.git',
              'clone_url' => 'https://github.com/ImMPrada/art_musseum.git',
              'svn_url' => 'https://github.com/ImMPrada/art_musseum',
              'homepage' => 'art-musseum.vercel.app',
              'size' => 720,
              'stargazers_count' => 0,
              'watchers_count' => 0,
              'language' => 'JavaScript',
              'has_issues' => true,
              'has_projects' => true,
              'has_downloads' => true,
              'has_wiki' => true,
              'has_pages' => false,
              'forks_count' => 0,
              'mirror_url' => nil,
              'archived' => false,
              'disabled' => false,
              'open_issues_count' => 3,
              'license' => nil,
              'allow_forking' => true,
              'is_template' => false,
              'web_commit_signoff_required' => false,
              'topics' => [],
              'visibility' => 'public',
              'forks' => 0,
              'open_issues' => 3,
              'watchers' => 0,
              'default_branch' => 'main'
            }
          ]
      )
      allow(Github::ApiClient).to receive(:new).and_return(repos_response)
    end

    it 'returns right body class' do
      expect(repos_consumer.call.class).to eq(Array)
    end

    it 'returns right body content' do
      expect(repos_consumer.call).to eq(expected_response)
    end
  end

  describe 'when the profile exists on github, ApiClient code: 4XX' do
    let(:expected_response) { nil }

    before do
      profile_response = instance_double(
        Github::ApiClient,
        fetch_profile_repos: {},
        code: 403,
        body: nil
      )
      allow(Github::ApiClient).to receive(:new).and_return(profile_response)
    end

    it 'returns right body class' do
      expect(repos_consumer.call.class).to eq(NilClass)
    end

    it 'returns right body content' do
      expect(repos_consumer.call).to eq(expected_response)
    end
  end
end
