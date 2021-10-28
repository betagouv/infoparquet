
class DSController < ApplicationController
    before_action :authenticate_user!, :except => [:event]
    protect_from_forgery :except => [:event]

    def event
        puts "RECEIVED WEBHOOK EVENT"
        puts params
    end

    def index 
       dossiers = DSDossier.get_all() 
       if !current_user.role_root?
            dossiers = dossiers.select {|d| d.usager_email == current_user.email}
       end

       search = params[:search]

       if search
            dossiers = dossiers.select do |dossier|
                dossier.reference_dossier.downcase.include?(search.downcase) ||
                dossier.nature_affaire.downcase.include?(search.downcase) ||
                dossier.lieux.any? {|lieu| lieu.downcase.include? search.downcase }
            end
       end

       urgence = ["true", "oui", "1", 1].include? params[:urgence]

       if urgence
            dossiers = dossiers.select {|d| d.urgence }
       end

       page = params[:page].to_i || 0
       limit = !params[:limit] || params[:limit].to_i <= 0 ? 10 : params[:limit].to_i
       pageCount = (dossiers.length.to_f / limit.to_f).ceil

       if limit != nil
            dossiers = dossiers.slice(page*limit, limit)
            if dossiers == nil
                dossiers = []
            end
       end
        
       @dossiers = dossiers
       @page = page
       @limit = limit
       @pageCount = pageCount
       @search = search

       respond_to do |format|
            format.js {render layout: false}
            format.html {render 'index'}
       end
    end
end