class NotifyReauthWorker
  include Sidekiq::Worker

  def perform date
    User.all.each do |user|
      user.evernote_accounts.each do |acc|
        expires_at = acc.token_expires_at
        if expires_at < (Time.now + 1.month)
          notify user.id, 'Evernote', expires_at
        end
      end
      user.facebook_accounts.each do |acc|
        expires_at = acc.token_expires_at
        if expires_at < (Time.now + 1.month)
          notify user.id, 'Facebook', expires_at
        end
      end
    end
  end

  def notify user_id, service, expires_at
    UserMailer.notify_reauth(user_id, service, expires_at).deliver
  end
end