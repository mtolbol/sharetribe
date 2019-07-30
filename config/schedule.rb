if @rbenv_root
  job_type :rake,    %{cd :path && :environment_variable=:environment :rbenv_root/bin/rbenv exec bundle exec rake :task --silent :output}
  job_type :runner,  %{cd :path && :rbenv_root/bin/rbenv exec bundle exec rails runner -e :environment ':task' :output}
  job_type :script,  %{cd :path && :environment_variable=:environment :rbenv_root/bin/rbenv exec bundle exec script/:task :output}
end

every 1.day do
  # Clean up expired sessions
  runner "ActiveSessionsHelper.cleanup"

  # Send daily/weekly marketplace digest emails
  runner "CommunityMailer.deliver_community_updates"

  # Clean up expired auth tokens
  rake "sharetribe:delete_expired_auth_tokens"
end

every 1.hour do
  # Keep search indexes reasonably up to date
  rake "ts:index"
end
