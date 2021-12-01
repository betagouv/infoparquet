class DsDossier
    DOSSIER_FRAGMENT = DSAPI::Client.parse <<-'GRAPHQL'
        fragment on Dossier {
            id
            number
            usager {
                email
            }
            champs {
                __typename
                label
                value: stringValue
                ... on RepetitionChamp {
                    champs {
                        __typename
                        label
                        value: stringValue
                        ... on PieceJustificativeChamp {
                            file {
                                url
                                filename
                            }
                        }
                    }
                }
            }
        }
    GRAPHQL

    GET_DOSSIER_QUERY = DSAPI::Client.parse <<-'GRAPHQL'
        query ($dossierId: Int!){
            dossier(number: $dossierId) {
                ...DsDossier::DOSSIER_FRAGMENT 
            }
        }
    GRAPHQL

    GET_ALL_DOSSIER_QUERY = DSAPI::Client.parse <<-'GRAPHQL'
        query ($demarcheId: Int!) {
            demarche(number: $demarcheId) {
                dossiers {
                    nodes {
                        ...DsDossier::DOSSIER_FRAGMENT
                    }
                }
            }
        }
    GRAPHQL

    def self.get_all()
        result = DSAPI::Client.query(
            GET_ALL_DOSSIER_QUERY,
            variables: { demarcheId: ENV['DS_DEMARCHE_ID'].to_i }
        )

        unless result.data and result.data.demarche
            raise StandardError.new "No data returned from DS"
        end

        demarche_data = result.data.demarche
        
        dossiers = demarche_data.dossiers.nodes.map do |dossier_data|
            parse_dossier(dossier_data)
        end

    end

    def self.get(dossier_number)
        result = DSAPI::Client.query(
            GET_DOSSIER_QUERY,
            variables: { dossierId: dossier_number }
        )

        unless result.data and result.data.dossier
            raise StandardError.new "No data returned from DS"
        end

        parse_dossier(result.data.dossier)
    end

    def self.parse_dossier(query_result)
        dossier_data = DsDossier::DOSSIER_FRAGMENT.new(query_result)
        dossier = DsDossier.new

        dossier.id = dossier_data.id
        dossier.number = dossier_data.number
        dossier.usager_email = dossier_data.usager.email

        dossier_data.champs.each do |champ|
            label = champ.label
            stringValue = champ.value

            if label == "Administration"
                dossier.administration = stringValue
            elsif label == "Direction / Service"
                dossier.direction_service = stringValue
            elsif label == "Il s'agit d'une urgence"
                dossier.urgence = ["true", "oui", "1"].include? stringValue.downcase
            elsif label == "Nature de l'affaire"
                dossier.nature_affaire = stringValue
            elsif label == "Date des faits"
                dossier.date_faits = stringValue
            elsif label == "Lieu(x) des faits"
                if champ.__typename == "RepetitionChamp"
                    lieux = champ.champs
                    if lieux
                        dossier.lieux = lieux.map do |lieu|
                            lieu.value
                        end
                    end
                elsif champ.__typename == "TextChamp"
                    dossier.lieux = [stringValue]
                end
            elsif label == "Type de contentieux"
                dossier.type_contentieux = stringValue
            elsif label == "Motif de signalement"
                dossier.motif_signalement = stringValue
            elsif label == "Références du dossier pour votre administration"
                dossier.reference_dossier = stringValue
            elsif label == "Commentaire"
                dossier.commentaire = stringValue
            elsif label == "Procédure"
                pieces = champ.champs
                if pieces
                    dossier.pieces_jointes = pieces.map do |piece|
                        if piece.file
                            {
                                :url => piece.file.url,
                                :filename => piece.file.filename
                            }
                        end
                    end
                    dossier.pieces_jointes = dossier.pieces_jointes.compact
                end
            end
        end

        dossier
    end

    attr_accessor :id
    attr_accessor :number
    attr_accessor :administration
    attr_accessor :direction_service
    attr_accessor :urgence
    attr_accessor :nature_affaire
    attr_accessor :date_faits
    attr_accessor :lieux
    attr_accessor :type_contentieux
    attr_accessor :motif_signalement
    attr_accessor :reference_dossier
    attr_accessor :commentaire
    attr_accessor :pieces_jointes
    attr_accessor :usager_email

    def initialize
        @id = ""
        @number = -1
        @administration = "N/A"
        @direction_service = "N/A"
        @urgence = false
        @nature_affaire = "N/A"
        @date_faits = "N/A"
        @lieux = ["N/A"]
        @type_contentieux = "N/A"
        @motif_signalement = "N/A"
        @reference_dossier = ""
        @commentaire = ""
        @pieces_jointes = []
    end
end


