require "net/https"

module EvernoteApiHelper

  def evernote_data
    User.all.each do |user|
      if user.evernote_oauth_token
        save_notes_on (Time.now), user
      end
    end
  end

  def user_notes_created_on date, client
    notes = client.note_store.findNotes(Evernote::EDAM::NoteStore::NoteFilter.new, 0, 100).notes
    notes.select { |note| Time.at(note.created.to_s[0..-4].to_i) == date.to_s[0..9] }
  end

  def user_notes_updated_on date, client
    notes = client.note_store.findNotes(Evernote::EDAM::NoteStore::NoteFilter.new, 0, 100).notes
    notes.select { |note| Time.at(note.updated.to_s[0..-4].to_i) == date.to_s[0..9] }
  end

  def create_user_client user
    client = EvernoteOAuth::Client.new(consumer_key: ENV['EVERNOTE_CONSUMER_KEY'], consumer_secret: ENV['EVERNOTE_CONSUMER_SECRET'], sandbox:true)
    token = user.evernote_oauth_token
    client = EvernoteOAuth::Client.new(token: token)
  end

  def save_notes_on date, user
    client = create_user_client user
    updated_notes = user_notes_updated_on date, client
    created_notes = user_notes_created_on date, client
    updated_notes = updated_notes - created_notes 
    save_notes_created_on date, user, created_notes
    save_notes_updated_on date, user, updated_notes
  end

  def save_notes_created_on date, user, notes    
    notes.each do |note|
      unless EvernoteEntry.exists?(note_id: note.guid)
        EvernoteEntry.create(user_id: user.id, time_created: date.to_s, note_id: note.guid, kind: "created", title: note.title)
      end
    end
  end

  def save_notes_updated_on date, user, notes
    notes.each do |note|
      unless EvernoteEntry.exists?(note_id: note.guid)
        EvernoteEntry.create(user_id: user.id, time_created: date.to_s, note_id: note.guid, kind: "updated", title: note.title)
      end
    end
  end

end
