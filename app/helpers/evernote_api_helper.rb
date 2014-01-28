require "net/https"

module EvernoteApiHelper

  def evernote_data
    User.all.each do |user|
      if user.evernote_oauth_token

      end
    end
  end

  def user_notes_on date, user
    
  end

  def save_notes_on date, user
    notes = user_notes_on date, user
    notes.each do |note|
      unless EvernoteEntry.exists?(user_id: user.id, note_id: note['id'])
        EvernoteEntry.create(user_id: user.id, time_created: date.to_s)
      end
    end
  end

end
