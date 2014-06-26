class WhatpulseEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :whatpulse_account
end
