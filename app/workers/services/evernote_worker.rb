class EvernoteWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'external_api'

  def perform date, user_id
    user = User.find(user_id)
    accounts = user.evernote_accounts.select { |a| a.activated }
    accounts.each do |account|
      client = create_client_for account
      updated_notes = user_notes_updated_on date, client
      created_notes = user_notes_created_on date, client
      updated_notes = updated_notes - created_notes
      save_notes_created_on date, created_notes, user_id, account.id
      save_notes_updated_on date, updated_notes, user_id, account.id
    end
  end

  def user_notes_created_on date, client
    notes = client.note_store.findNotes(Evernote::EDAM::NoteStore::NoteFilter.new, 0, 100).notes
    notes.select { |note| Time.at(note.created.to_s[0..-4].to_i).to_s[0..9] == date.to_s[0..9] }
  end

  def user_notes_updated_on date, client
    notes = client.note_store.findNotes(Evernote::EDAM::NoteStore::NoteFilter.new, 0, 100).notes
    notes.select { |note| Time.at(note.updated.to_s[0..-4].to_i).to_s[0..9] == date.to_s[0..9] }
  end

  def create_client_for account
    client = EvernoteOAuth::Client.new(
      consumer_key: ENV['EVERNOTE_CONSUMER_KEY'],
      consumer_secret: ENV['EVERNOTE_CONSUMER_SECRET'],
      sandbox:true
    )
    token = account.oauth_token
    client = EvernoteOAuth::Client.new(token: token)
  end

  def save_notes_created_on date, notes, user_id, account_id
    notes.each do |note|
      unless EvernoteEntry.exists?(note_id: note.guid)
        EvernoteEntry.create(
          user_id: user_id,
          date: date.to_s[0..9],
          note_id: note.guid,
          kind: "created",
          title: note.title,
          evernote_account_id: account_id
        )
      end
    end
  end

  def save_notes_updated_on date, notes, user_id, account_id
    notes.each do |note|
      unless EvernoteEntry.exists?(note_id: note.guid)
        EvernoteEntry.create(
          user_id: user_id,
          date: date.to_s[0..9],
          note_id: note.guid,
          kind: "updated",
          title: note.title,
          evernote_account_id: account_id
        )
      end
    end
  end
end