# frozen_string_literal: true

RSpec.describe Legion::Extensions::Grafana::Runners::Datasources do
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

  describe '#list_datasources' do
    it 'returns all datasources' do
      stubs.get('/api/datasources') do
        [200, { 'Content-Type' => 'application/json' },
         [{ 'id' => 1, 'name' => 'Prometheus', 'type' => 'prometheus', 'url' => 'http://prometheus:9090' }]]
      end
      result = client.list_datasources
      expect(result).to be_an(Array)
      expect(result.first['name']).to eq('Prometheus')
    end
  end

  describe '#get_datasource' do
    it 'returns a datasource by id' do
      stubs.get('/api/datasources/1') do
        [200, { 'Content-Type' => 'application/json' },
         { 'id' => 1, 'name' => 'Prometheus', 'type' => 'prometheus' }]
      end
      result = client.get_datasource(id: 1)
      expect(result['id']).to eq(1)
      expect(result['type']).to eq('prometheus')
    end
  end

  describe '#create_datasource' do
    it 'creates a datasource and returns the result' do
      stubs.post('/api/datasources') do
        [200, { 'Content-Type' => 'application/json' },
         { 'id' => 2, 'name' => 'Loki', 'message' => 'Datasource added' }]
      end
      ds = { 'name' => 'Loki', 'type' => 'loki', 'url' => 'http://loki:3100', 'access' => 'proxy' }
      result = client.create_datasource(datasource: ds)
      expect(result['message']).to eq('Datasource added')
      expect(result['name']).to eq('Loki')
    end
  end
end
