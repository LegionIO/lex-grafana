# frozen_string_literal: true

require 'faraday'

module Legion
  module Extensions
    module Grafana
      module Helpers
        module Client
          def connection(url: nil, api_key: nil, **_opts)
            base = url || settings.dig(:transport, :settings, :'lex-grafana', :url)
            key  = api_key || settings.dig(:transport, :settings, :'lex-grafana', :api_key)
            Faraday.new(url: base) do |f|
              f.request :json
              f.response :json
              f.headers['Authorization'] = "Bearer #{key}" if key
              f.adapter Faraday.default_adapter
            end
          end
        end
      end
    end
  end
end
