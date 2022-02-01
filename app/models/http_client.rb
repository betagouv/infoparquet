class HttpClient
    def self.request method, uri, body = nil, headers = {}, authorization = nil
        uri = URI(uri)
        https = make_url uri

        request = nil
        
        if method == :POST
            request = Net::HTTP::Post.new uri.path
        elsif method == :GET
            request = Net::HTTP::Get.new uri.path
        elsif method == :PUT
            request = Net::HTTP::Put.new uri.path
        elsif method == :DELETE
            request = Net::HTTP::Delete.new uri.path
        end

        if body != nil
            if body.is_a? Hash
                request["Content-Type"] = "application/json"
                request["accept"] = "application/json"
                request.body = body.to_json
            else
                request.body = body
            end
        end

        if authorization != nil
            if authorization.is_a? Hash and authorization.key? "access_token"
                request["Authorization"] = "Bearer #{authorization["access_token"]}"
            else
                request["Authorization"] = authorization
            end
        end

        headers.each do |key, value|
            request[key] = value
        end

        response = https.request(request)

        if response.code.to_i >= 400
            puts response.body
            raise StandardError.new response
        end

        return response
    end


    def self.get uri, headers = {}, authorization = nil
        return request :GET, uri, headers: headers, authorization: authorization
    end

    def self.post uri, body = nil, headers = {}, authorization = nil
        request :POST, uri, body, headers, authorization
    end

    def self.put uri, body = nil, headers = {}, authorization = nil
        request :PUT, uri, body, headers, authorization
    end

    def self.delete uri, body = nil, headers = {}, authorization = nil
        request :DELETE, uri, body, headers, authorization
    end

    private
        def self.make_url uri
            https = Net::HTTP.new uri.host, uri.port
            https.use_ssl = uri.port == 443

            return https
        end
end