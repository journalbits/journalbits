class LastfmEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :lastfm_account
end
