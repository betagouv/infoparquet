
class WebhookController < ApplicationController
    protect_from_forgery with: :null_session

    def event
        puts "RECEIVED WEBHOOK EVENT"
        puts params
    end
end