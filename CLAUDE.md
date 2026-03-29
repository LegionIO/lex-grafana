# lex-grafana: Grafana HTTP API Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-other/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Legion extension for interacting with the Grafana HTTP API. Supports dashboard CRUD, alert management, and datasource operations.

**GitHub**: https://github.com/LegionIO/lex-grafana
**Gem**: `lex-grafana`
**Version**: 0.1.2
**License**: MIT
**Ruby**: >= 3.4

## Architecture

### Runners

| Runner | Methods | Description |
|--------|---------|-------------|
| `Dashboards` | `list_dashboards`, `get_dashboard`, `create_dashboard`, `delete_dashboard` | Dashboard CRUD |
| `Alerts` | `list_alerts`, `list_alert_rules`, `pause_alert` | Alert management |
| `Datasources` | `list_datasources`, `get_datasource`, `create_datasource` | Datasource management |

### Helpers

- `Helpers::Client` — Faraday connection factory. Connects to Grafana base URL with Bearer token auth. URL and API key resolved from kwargs or Legion::Settings.

### Standalone Client

```ruby
client = Legion::Extensions::Grafana::Client.new(url: 'https://grafana.example.com', api_key: 'KEY')
client.list_dashboards
client.get_dashboard(uid: 'abc123')
client.list_alerts
```

## Authentication

Bearer token via `Authorization: Bearer <api_key>` header.

## Settings

```json
{
  "lex-grafana": {
    "url": "https://grafana.example.com",
    "api_key": "vault://secret/grafana#api_key"
  }
}
```

## File Map

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/grafana.rb` | Entry point |
| `lib/legion/extensions/grafana/version.rb` | Version constant |
| `lib/legion/extensions/grafana/helpers/client.rb` | Faraday connection factory |
| `lib/legion/extensions/grafana/runners/dashboards.rb` | Dashboard CRUD |
| `lib/legion/extensions/grafana/runners/alerts.rb` | Alert management |
| `lib/legion/extensions/grafana/runners/datasources.rb` | Datasource management |
| `lib/legion/extensions/grafana/client.rb` | Standalone Client class |

## Development

```bash
bundle install
bundle exec rspec       # 15 examples, 0 failures
bundle exec rubocop     # 0 offenses
```

---

**Maintained By**: Matthew Iverson (@Esity)
