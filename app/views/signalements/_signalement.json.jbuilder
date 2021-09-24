json.extract! signalement, :id, :type, :urgence, :motif, :reference_administration, :commentaire, :reference_juridiction, :created_at, :updated_at
json.url signalement_url(signalement, format: :json)
