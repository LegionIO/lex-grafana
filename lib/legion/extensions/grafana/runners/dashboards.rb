# frozen_string_literal: true

module Legion
  module Extensions
    module Grafana
      module Runners
        module Dashboards
          def list_dashboards(**opts)
            conn = opts[:connection] || connection(**opts)
            response = conn.get('api/search', type: 'dash-db')
            response.body
          end

          def get_dashboard(uid:, **opts)
            conn = opts[:connection] || connection(**opts)
            response = conn.get("api/dashboards/uid/#{uid}")
            response.body
          end

          def create_dashboard(dashboard:, folder_id: nil, overwrite: false, **opts)
            conn = opts[:connection] || connection(**opts)
            payload = { dashboard: dashboard, overwrite: overwrite }
            payload[:folderId] = folder_id if folder_id
            response = conn.post('api/dashboards/db', payload)
            response.body
          end

          def delete_dashboard(uid:, **opts)
            conn = opts[:connection] || connection(**opts)
            response = conn.delete("api/dashboards/uid/#{uid}")
            response.body
          end
        end
      end
    end
  end
end
