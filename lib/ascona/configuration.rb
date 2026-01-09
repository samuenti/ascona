# frozen_string_literal: true

module Ascona
  class Configuration
    attr_accessor :icon_path, :default_library, :default_variants, :default_size

    def initialize
      @icon_path = "app/assets/icons"
      @default_library = nil
      @default_variants = {}
      @default_size = nil
    end
  end
end
