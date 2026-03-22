# frozen_string_literal: true

RSpec.describe Legion::Extensions::Grafana::Runners::Dashboards do
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

  describe '#list_dashboards' do
    it 'returns list of dashboards' do
      stubs.get('/api/search') do
        [200, { 'Content-Type' => 'application/json' },
         [{ 'uid' => 'abc123', 'title' => 'My Dashboard', 'type' => 'dash-db' }]]
      end
      result = client.list_dashboards
      expect(result).to be_an(Array)
      expect(result.first['uid']).to eq('abc123')
    end
  end

  describe '#get_dashboard' do
    it 'returns a dashboard by uid' do
      stubs.get('/api/dashboards/uid/abc123') do
        [200, { 'Content-Type' => 'application/json' },
         { 'dashboard' => { 'uid' => 'abc123', 'title' => 'My Dashboard' }, 'meta' => {} }]
      end
      result = client.get_dashboard(uid: 'abc123')
      expect(result['dashboard']['uid']).to eq('abc123')
    end
  end

  describe '#create_dashboard' do
    it 'creates a dashboard and returns the result' do
      stubs.post('/api/dashboards/db') do
        [200, { 'Content-Type' => 'application/json' },
         { 'id' => 1, 'uid' => 'newuid', 'status' => 'success', 'url' => '/d/newuid/title' }]
      end
      dashboard = { 'title' => 'New Dashboard', 'panels' => [] }
      result = client.create_dashboard(dashboard: dashboard)
      expect(result['status']).to eq('success')
      expect(result['uid']).to eq('newuid')
    end
  end

  describe '#delete_dashboard' do
    it 'deletes a dashboard by uid' do
      stubs.delete('/api/dashboards/uid/abc123') do
        [200, { 'Content-Type' => 'application/json' },
         { 'title' => 'My Dashboard', 'message' => 'Dashboard My Dashboard deleted' }]
      end
      result = client.delete_dashboard(uid: 'abc123')
      expect(result['message']).to include('deleted')
    end
  end
end
