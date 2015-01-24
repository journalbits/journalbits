class UserMailer < ActionMailer::Base
  default from: 'JournalBits <admin@journalbits.net>'

  def welcome user
    @user = user
    mail(to: @user.email, subject: 'Welcome to JournalBits')
  end

  def notify_reauth acc, service, expires_at
    @user = User.find(acc.user_id)
    @time = day_week_or_month? expires_at
    @service = acc.class == EvernoteAccount ? "#{service} (#{acc.username})"
                                            : service
    mail(to: @user.email, subject: "Reauthorize #{@service} on JournalBits")
  end

  def daily_summary user_id
    @user = User.find(user_id)
    mail(to: @user.email, subject: 'JournalBits Daily Summary')
  end

  private

  def day_week_or_month? expires_at
    return 'day' if expires_at - Time.now < 60*60*24
    return 'week' if expires_at - Time.now < 60*60*24*7
    return 'month'
  end
end
