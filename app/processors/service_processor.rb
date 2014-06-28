# module ServiceProcessor
#   class GlobalProcessor
#     def initialize date
#       @date = date
#     end

#     def process_all_new_entries
#       User.all.each do |user|
#         EvernoteWorker.perform_async(@date, user.id)
#         FacebookWorker.perform_async(@date, user.id)
#         FitbitWorker.perform_async(@date, user.id)
#         GithubWorker.perform_async(@date, user.id)
#         HealthGraphWorker.perform_async(@date, user.id)
#         InstagramWorker.perform_async(@date, user.id)
#         # InstapaperWorker.perform_async(@date, user.id)
#         LastfmWorker.perform_async(@date, user.id)
#         MovesWorker.perform_async(@date, user.id)
#         PocketWorker.perform_async(@date, user.id)
#         TwitterWorker.perform_async(@date, user.id)
#         WhatpulseWorker.perform_async(@date, user.id)
#         WunderlistWorker.perform_async(@date, user.id)
#       end
#     end

#     def process_rescue_time_entries
#       User.all.each do |user|
#         RescueTimeWorker.perform_async(@date, user.id)
#       end
#     end
#   end
# end