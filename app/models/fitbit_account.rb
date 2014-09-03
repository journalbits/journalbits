# == Schema Information
#
# Table name: fitbit_accounts
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  oauth_token  :string(255)
#  oauth_secret :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  public       :boolean          default(TRUE)
#  activated    :boolean          default(TRUE)
#  name         :string(255)
#

class FitbitAccount < ActiveRecord::Base
  belongs_to :user

end
