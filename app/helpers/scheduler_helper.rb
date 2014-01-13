require "net/https"

module SchedulerHelper

  def scheduler_test
    # puts "hello"
  end

  def twitter_favorites
    User.all.each do |user|
      puts user.email
    end
  end

end