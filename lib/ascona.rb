# frozen_string_literal: true

require_relative "ascona/version"
require_relative "ascona/configuration"
require_relative "ascona/registry"
require_relative "ascona/helper"

module Ascona
  class Error < StandardError; end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def registry
      @registry ||= Registry.new
    end

    def load
      registry.load(configuration.icon_path)
    end
  end
end

require_relative "ascona/railtie" if defined?(Rails)
