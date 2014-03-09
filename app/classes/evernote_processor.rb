require "net/https"

module ServiceProcessor
  class EvernoteProcessor
    def initialize date, user
      @user = user
      @date = date
      @client = create_user_client
    end

    def process 
      save_notes_on_date
    end

    def user_notes_created_on_date
      notes = @client.note_store.findNotes(Evernote::EDAM::NoteStore::NoteFilter.new, 0, 100).notes
      notes.select { |note| Time.at(note.created.to_s[0..-4].to_i).to_s[0..9] == @date.to_s[0..9] }
    end

    def user_notes_updated_on_date
      notes = @client.note_store.findNotes(Evernote::EDAM::NoteStore::NoteFilter.new, 0, 100).notes
      notes.select { |note| Time.at(note.updated.to_s[0..-4].to_i).to_s[0..9] == @date.to_s[0..9] }
    end

    def create_user_client
      client = EvernoteOAuth::Client.new(consumer_key: ENV['EVERNOTE_CONSUMER_KEY'], 
                                         consumer_secret: ENV['EVERNOTE_CONSUMER_SECRET'], 
                                         sandbox:true)
      token = @user.evernote_oauth_token
      client = EvernoteOAuth::Client.new(token: token)
    end

    def save_notes_on_date
      updated_notes = user_notes_updated_on_date
      created_notes = user_notes_created_on_date
      updated_notes = updated_notes - created_notes 
      save_notes_created_on_date created_notes
      save_notes_updated_on_date updated_notes
    end

    def save_notes_created_on_date notes    
      notes.each do |note|
        unless EvernoteEntry.exists?(note_id: note.guid)
          EvernoteEntry.create(user_id: @user.id, 
                               date: @date.to_s[0..9], 
                               note_id: note.guid, 
                               kind: "created", 
                               title: note.title)
        end
      end
    end

    def save_notes_updated_on_date notes
      notes.each do |note|
        unless EvernoteEntry.exists?(note_id: note.guid)
          EvernoteEntry.create(user_id: @user.id, 
                               date: @date.to_s[0..9], 
                               note_id: note.guid, 
                               kind: "updated", 
                               title: note.title)
        end
      end
    end
  end
end