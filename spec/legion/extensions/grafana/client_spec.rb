# frozen_string_literal: true

RSpec.describe Legion::Extensions::Grafana::Client do
  subject(:client) do
    described_class.new(
      url:     'http://grafana:3000',
      api_key: 'test-api-key'
    )
  end

  describe '#initialize' do
    it 'stores url in opts' do
      expect(client.opts[:url]).to eq('http://grafana:3000')
    end

    it 'stores api_key in opts' do
      expect(client.opts[:api_key]).to eq('test-api-key')
    end
  end

  describe '#settings' do
    it 'returns a hash with options key' do
      expect(client.settings).to eq({ options: client.opts })
    end
  end

  describe '#connection' do
    it 'returns a Faraday connection' do
      expect(client.connection).to be_a(Faraday::Connection)
    end

    it 'sets Authorization header when api_key is present' do
      conn = client.connection
      expect(conn.headers['Authorization']).to eq('Bearer test-api-key')
    end
  end
end
