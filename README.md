# lex-grafana

Grafana integration for [LegionIO](https://github.com/LegionIO/LegionIO). Query and manage dashboards, alerts, and datasources via the Grafana HTTP API from within Legion task chains or as a standalone client library.

## Installation

```bash
gem install lex-grafana
```

Or add to your Gemfile:

```ruby
gem 'lex-grafana'
```

## Standalone Usage

```ruby
require 'legion/extensions/grafana'

client = Legion::Extensions::Grafana::Client.new(
  url: 'https://grafana.example.com',
  api_key: 'glsa_xxxxxxxxxxxx'
)

# Dashboards
client.list_dashboards
client.get_dashboard(uid: 'abc123')
client.create_dashboard(dashboard: { title: 'My Board', panels: [] }, overwrite: false)
client.delete_dashboard(uid: 'abc123')

# Alerts
client.list_alerts
client.list_alert_rules
client.pause_alert(alert_id: 1, paused: true)

# Datasources
client.list_datasources
client.get_datasource(id: 1)
client.create_datasource(name: 'Prometheus', type: 'prometheus', url: 'http://prometheus:9090')
```

## Runners

### Dashboards

| Method | Parameters | Description |
|--------|-----------|-------------|
| `list_dashboards` | — | List all dashboards |
| `get_dashboard` | `uid:` | Get dashboard by UID |
| `create_dashboard` | `dashboard:`, `overwrite:` | Create or update a dashboard |
| `delete_dashboard` | `uid:` | Delete a dashboard |

### Alerts

| Method | Parameters | Description |
|--------|-----------|-------------|
| `list_alerts` | — | List legacy alerts |
| `list_alert_rules` | — | List Grafana-managed alert rules |
| `pause_alert` | `alert_id:`, `paused:` | Pause or unpause an alert |

### Datasources

| Method | Parameters | Description |
|--------|-----------|-------------|
| `list_datasources` | — | List all datasources |
| `get_datasource` | `id:` | Get datasource by ID |
| `create_datasource` | `name:`, `type:`, `url:`, ... | Create a datasource |

## Configuration

```json
{
  "lex-grafana": {
    "url": "https://grafana.example.com",
    "api_key": "vault://secret/grafana#api_key"
  }
}
```

## Requirements

- Ruby >= 3.4
- Grafana >= 8.0 (for alert rules API)
- `faraday` >= 2.0

## License

MIT
