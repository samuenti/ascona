# frozen_string_literal: true

module Ascona
  class Configuration
    attr_accessor :icon_path, :default_library

    def initialize
      @icon_path = "app/assets/icons"
      @default_library = nil
    end
  end
end
