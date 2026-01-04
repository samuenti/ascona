# frozen_string_literal: true

module Ascona
  class Registry
    def initialize
      @icons = {}
    end

    def load(path)
      Dir.glob(File.join(path, "*")).each do |library_dir|
        next unless File.directory?(library_dir)

        library_name = File.basename(library_dir).to_sym
        @icons[library_name] = {}

        Dir.glob(File.join(library_dir, "*.svg")).each do |file|
          icon_name = File.basename(file, ".svg").to_sym
          @icons[library_name][icon_name] = File.read(file)
        end
      end
    end

    def get(name, library:)
      @icons.dig(library, name)
    end

    def libraries
      @icons.keys
    end
  end
end
