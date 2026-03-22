# frozen_string_literal: true

require 'legion/extensions/grafana/version'
require 'legion/extensions/grafana/helpers/client'
require 'legion/extensions/grafana/runners/dashboards'
require 'legion/extensions/grafana/runners/alerts'
require 'legion/extensions/grafana/runners/datasources'
require 'legion/extensions/grafana/client'

module Legion
  module Extensions
    module Grafana
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
