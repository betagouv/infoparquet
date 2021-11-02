class ApplicationMailer < ActionMailer::Base
  default from: 'ne_pas_repondre@infoparquet.beta.gouv.fr'
  layout 'mailer'
end
