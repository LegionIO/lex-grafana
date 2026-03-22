# frozen_string_literal: true

module Legion
  module Extensions
    module Grafana
      module Runners
        module Datasources
          def list_datasources(**opts)
            conn = opts[:connection] || connection(**opts)
            response = conn.get('api/datasources')
            response.body
          end

          def get_datasource(id:, **opts)
            conn = opts[:connection] || connection(**opts)
            response = conn.get("api/datasources/#{id}")
            response.body
          end

          def create_datasource(datasource:, **opts)
            conn = opts[:connection] || connection(**opts)
            response = conn.post('api/datasources', datasource)
            response.body
          end
        end
      end
    end
  end
end
