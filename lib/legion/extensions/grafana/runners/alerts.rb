# frozen_string_literal: true

module Legion
  module Extensions
    module Grafana
      module Runners
        module Alerts
          def list_alerts(**opts)
            conn = opts[:connection] || connection(**opts)
            response = conn.get('api/alerts')
            response.body
          end

          def list_alert_rules(**opts)
            conn = opts[:connection] || connection(**opts)
            response = conn.get('api/v1/provisioning/alert-rules')
            response.body
          end

          def pause_alert(id:, paused:, **opts)
            conn = opts[:connection] || connection(**opts)
            response = conn.post("api/alerts/#{id}/pause", paused: paused)
            response.body
          end
        end
      end
    end
  end
end
