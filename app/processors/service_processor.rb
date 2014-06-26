# require 'evernote_processor'
# require 'facebook_processor'
# require 'fitbit_processor'
# require 'github_processor'
# require 'health_graph_processor'
# require 'instagram_processor'
# require 'instapaper_processor'
# require 'lastfm_processor'
# require 'moves_processor'
# require 'pocket_processor'
# require 'rescue_time_processor'
# require 'twitter_processor'
# require 'whatpulse_processor'
# require 'wunderlist_processor'

# include ServiceProcessor

module ServiceProcessor
  class GlobalProcessor
    def initialize date
      @date = date
    end

    def process_all
      User.all.each do |user|
        EvernoteWorker.perform_async(@date, user.id)
        FacebookWorker.perform_async(@date, user.id)
        FitbitWorker.perform_async(@date, user.id)
        GithubWorker.perform_async(@date, user.id)
        HealthGraphWorker.perform_async(@date, user.id)
        InstagramWorker.perform_async(@date, user.id)
        # InstapaperWorker.perform_async(@date, user.id)
        LastfmWorker.perform_async(@date, user.id)
        MovesWorker.perform_async(@date, user.id)
        PocketWorker.perform_async(@date, user.id)
        RescueTimeWorker.perform_async(@date, user.id)
        TwitterWorker.perform_async(@date, user.id)
        WhatpulseWorker.perform_async(@date, user.id)
        WunderlistWorker.perform_async(@date, user.id)
      end
    end

    # def process_all
    #   User.all.each do |user|
    #     # process_for_evernote user
    #     # process_for_facebook user
    #     # process_for_fitbit user
    #     # process_for_github user
    #     # process_for_health_graph user
    #     # process_for_instagram user
    #     # process_for_instapaper user
    #     # process_for_lastfm user
    #     # process_for_moves user
    #     # process_for_pocket user
    #     # process_for_rescue_time user
    #     # process_for_twitter user
    #     # process_for_whatpulse user
    #     # process_for_wunderlist user
    #   end
    # end

    # def process_for_evernote user
    #   if user.evernote_oauth_token
    #     evernote = ServiceProcessor::EvernoteProcessor.new @date, user
    #     evernote.process
    #   end
    # end

    # def process_for_facebook user
    #   if user.facebook_oauth_token
    #     facebook = ServiceProcessor::FacebookProcessor.new @date, user
    #     facebook.process
    #   end
    # end

    # def process_for_fitbit user
    #   if user.fitbit_oauth_token
    #     fitbit = ServiceProcessor::FitbitProcessor.new @date, user
    #     fitbit.process
    #   end
    # end

    # def process_for_github user
    #   if user.github_access_token
    #     github = ServiceProcessor::GithubProcessor.new @date, user
    #     github.process
    #   end
    # end

    # def process_for_health_graph user
    #   if user.health_graph_access_token
    #     health_graph = ServiceProcessor::HealthGraphProcessor.new @date, user
    #     health_graph.process
    #   end
    # end

    # def process_for_instagram user
    #   if user.instagram_oauth_token
    #     instagram = ServiceProcessor::InstagramProcessor.new @date, user
    #     instagram.process
    #   end
    # end

    # def process_for_instapaper user
    #   if user.instapaper_oauth_token
    #     instapaper = ServiceProcessor::InstapaperProcessor.new @date, user
    #     instapaper.process
    #   end
    # end

    # def process_for_lastfm user
    #   if user.lastfm_username
    #     lastfm = ServiceProcessor::LastfmProcessor.new @date, user
    #     lastfm.process
    #   end
    # end

    # def process_for_moves user
    #   if user.moves_oauth_token
    #     moves = ServiceProcessor::MovesProcessor.new @date, user
    #     moves.process
    #   end
    # end

    # def process_for_pocket user
    #   if user.pocket_oauth_token
    #     pocket = ServiceProcessor::PocketProcessor.new @date, user
    #     pocket.process
    #   end
    # end

    # def process_for_rescue_time user
    #   if user.rescue_time_key
    #     rescue_time = ServiceProcessor::RescueTimeProcessor.new @date, user
    #     rescue_time.process
    #   end
    # end

    # def process_for_twitter user
    #   if user.twitter_oauth_token
    #     twitter = ServiceProcessor::TwitterProcessor.new @date, user
    #     twitter.process
    #   end
    # end

    # def process_for_whatpulse user
    #   if user.whatpulse_username
    #     whatpulse = ServiceProcessor::WhatpulseProcessor.new @date, user
    #     whatpulse.process
    #   end
    # end

    # def process_for_wunderlist user
    #   if user.wunderlist_token
    #     wunderlist = ServiceProcessor::WunderlistProcessor.new @date, user
    #     wunderlist.process
    #   end
    # end
  end
end