class UserMailer < ActionMailer::Base
  default from: 'JournalBits'

  def welcome user
    @user = user
    mail(to: @user.email, subject: 'Welcome to JournalBits')
  end

  def notify_reauth user_id, service, expires_at
    @user = User.find(user_id)
    @time = day_week_or_month? expires_at
    @service = service
    mail(to: @user.email, subject: "Reauthorize #{service} on JournalBits")
  end

  private

  def day_week_or_month? expires_at
    return 'day' if expires_at - Time.now < 60*60*24
    return 'week' if expires_at - Time.now < 60*60*24*7
    return 'month'
  end
end
