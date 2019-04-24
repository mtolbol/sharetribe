every 1.day do
  # Clean up expired sessions
  runner "ActiveSessionsHelper.cleanup"

  # Send daily/weekly marketplace digest emails
  runner "CommunityMailer.deliver_community_updates"

  # Clean up expired auth tokens
  rake "sharetribe:delete_expired_auth_tokens"
end
