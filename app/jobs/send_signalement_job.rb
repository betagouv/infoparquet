class SendSignalementJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # get IDJ
    # update Signalement record with IdJ
    # generate PDF/A-3
    # send through PLEX
  end
end
