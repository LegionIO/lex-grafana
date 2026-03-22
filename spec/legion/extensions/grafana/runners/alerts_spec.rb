# frozen_string_literal: true

RSpec.describe Legion::Extensions::Grafana::Runners::Alerts do
  let(:client) do
    Legion::Extensions::Grafana::Client.new(url: 'http://grafana:3000', api_key: 'test-key')
  end

  let(:stubs) { Faraday::Adapter::Test::Stubs.new }
  let(:test_connection) do
    Faraday.new(url: 'http://grafana:3000') do |conn|
      conn.response :json
      conn.adapter :test, stubs
    end
  end

  before { allow(client).to receive(:connection).and_return(test_connection) }

  describe '#list_alerts' do
    it 'returns legacy alerts' do
      stubs.get('/api/alerts') do
        [200, { 'Content-Type' => 'application/json' },
         [{ 'id' => 1, 'dashboardId' => 1, 'name' => 'High CPU', 'state' => 'alerting' }]]
      end
      result = client.list_alerts
      expect(result).to be_an(Array)
      expect(result.first['name']).to eq('High CPU')
    end
  end

  describe '#list_alert_rules' do
    it 'returns unified alert rules' do
      stubs.get('/api/v1/provisioning/alert-rules') do
        [200, { 'Content-Type' => 'application/json' },
         [{ 'uid' => 'rule-uid', 'title' => 'CPU Alert', 'condition' => 'C' }]]
      end
      result = client.list_alert_rules
      expect(result).to be_an(Array)
      expect(result.first['title']).to eq('CPU Alert')
    end
  end

  describe '#pause_alert' do
    it 'pauses an alert by id' do
      stubs.post('/api/alerts/1/pause') do
        [200, { 'Content-Type' => 'application/json' },
         { 'alertId' => 1, 'state' => 'paused', 'message' => 'alert paused' }]
      end
      result = client.pause_alert(id: 1, paused: true)
      expect(result['state']).to eq('paused')
    end
  end
end
