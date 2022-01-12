class SrjController < ApplicationController

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

    def natinf
    end

end