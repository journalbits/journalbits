class ChangeTokenColumnToUsernameForWhatpulseAccounts < ActiveRecord::Migration
  def change
    rename_column :whatpulse_accounts, :token, :username
  end
end
