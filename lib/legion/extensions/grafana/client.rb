# frozen_string_literal: true

require_relative 'helpers/client'
require_relative 'runners/dashboards'
require_relative 'runners/alerts'
require_relative 'runners/datasources'

module Legion
  module Extensions
    module Grafana
      class Client
        include Helpers::Client
        include Runners::Dashboards
        include Runners::Alerts
        include Runners::Datasources

        attr_reader :opts

        def initialize(url:, api_key: nil, **extra)
          @opts = { url: url, api_key: api_key, **extra }
        end

        def settings
          { options: @opts }
        end

        def connection(**override)
          super(**@opts, **override)
        end
      end
    end
  end
end
