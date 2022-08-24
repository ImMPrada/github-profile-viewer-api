json.message @message

json.profile do
  json.partial! 'profile', profile: @profile
end

json.repos @profile.repos do |repo|
  json.partial! 'repo', repo: repo
end
