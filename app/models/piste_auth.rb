class PisteAuth
    def self.get_access_token
        client_id = Rails.application.credentials.config[:piste][:client_id]
        secret_key = Rails.application.credentials.config[:piste][:secret_key]

        response = HttpClient.post(
            "https://sandbox-oauth.piste.gouv.fr/api/oauth/token",
            "grant_type=client_credentials&client_id=#{client_id}&client_secret=#{secret_key}&scope=openid",
            {"Content-Type" => "application/x-www-form-urlencoded"}
        )
        
        token = JSON.parse(response.body)
    end
end