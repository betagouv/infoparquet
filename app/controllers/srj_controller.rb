class SrjController < ApplicationController
    before_action :authenticate_user!
    before_action :enrolled_user!

    def nataffs
        params.require(:search)
        search = params[:search]

        if search.match(/^[a-zA-Z][0-9]?[0-9]?$/)
            nataffs = Nataff.where("code ilike ?", "#{search.downcase()}%")
        else
            nataffs = Nataff.where('"desc" ilike ?', "%#{search.downcase()}%")
        end

        render json: nataffs.to_json
    end

    def natinfs
        params.require(:search)
        search = params[:search]

        if search.match(/^[0-9]+$/)
            natinfs = Natinf.where("numero ilike ?", "#{search.downcase()}%")
        else
            natinfs = Natinf.where('"desc" ilike ?', "%#{search.downcase()}%")
        end

        render json: natinfs.to_json
    end

end