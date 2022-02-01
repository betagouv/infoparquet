class SendSignalementJob < ApplicationJob
  queue_as :default

  def perform(signalement)
    idj = Idj.request_new_idj signalement
    signalement.idj = idj
    signalement.save 
    # generate PDF/A-3
    # send through PLEX
  end
end
