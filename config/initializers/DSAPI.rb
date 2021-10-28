require 'graphql/client'
require 'graphql/client/http'

module DSAPI

    SCHEMA_DIRECTORY_PATH = File.join(Rails.root, 'config', 'graphql').freeze
    SCHEMA_PATH = File.join(SCHEMA_DIRECTORY_PATH, 'ds_schema.json').freeze

    HTTP = GraphQL::Client::HTTP.new('https://www.demarches-simplifiees.fr/api/v2/graphql') do
        def headers(_context)
            {
                'Authorization' => "Bearer token=#{Rails.application.credentials.ds[:secret_token]}"
            }
        end
    end

    unless File.exists?(SCHEMA_PATH)
        FileUtils.mkdir_p(SCHEMA_DIRECTORY_PATH)
        GraphQL::Client.dump_schema(HTTP, SCHEMA_PATH)
    end

    Schema = GraphQL::Client.load_schema(SCHEMA_PATH)
    Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
end