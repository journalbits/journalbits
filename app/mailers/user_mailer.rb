class UserMailer < ActionMailer::Base
  default from: 'admin@journalbits.net'

  def welcome user
    @user = user
    mail(to: @user.email, subject: 'Welcome to JournalBits')
  end
end
