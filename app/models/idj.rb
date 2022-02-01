class Idj
    def self.request_new_idj(signalement)
        payload_get_idj = {
            :dateDemande => DateTime.now.to_s,
            :entiteDemandeurEnum => "CE",
            :idApplication => "CASSIOPEE",
            :typeFlux => "Module_IDJ",
            :codeAction => "I",
            :demandeIDJ => {
                :codeServDemandeur => "adm_srj",
                :libelleServDemandeur => "adm_lib",
                :codeServActeur => "tj_srj",
                :libelleServActeur => "tj_lib",
                :refProcedures => [
                    {
                        :dateRef => DateTime.now.to_s,
                        :refProcAjout => signalement.reference_administration
                    }
                ]
            }
        }

        if signalement.nataffs.length > 0
            payload_get_idj[:demandeIDJ][:nataffs] = [
                :dateNatAff => DateTime.now.to_s,
                :natAffsAp => signalement.nataffs.map {|nataff| nataff.code }
            ]
        end
        
        if signalement.natinfs.length > 0
            payload_get_idj[:demandeIDJ][:natInfs] = [
                :dateNatInf => DateTime.now.to_s,
                :natInfsAp => signalement.natinfs.map {|natinf| natinf.numero}
            ]
        end

        response = HttpClient.post(
            "https://sandbox-api.piste.gouv.fr//minju/identifiant-judiciaire/v2/idjs",
            payload_get_idj,
            {},
            PisteAuth.get_access_token
        )

        response = JSON.parse(response.body)
        response["listIdj"][0]
    end
end