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

        load_library(library_dir, library_name)
      end
    end

    def get(name, library:, variant: nil)
      library_icons = @icons[library]
      return nil unless library_icons

      if variant
        library_icons.dig(variant.to_sym, name)
      else
        library_icons[name]
      end
    end

    def libraries
      @icons.keys
    end

    private

    def load_library(library_dir, library_name)
      has_variants = Dir.glob(File.join(library_dir, "*")).any? { |f| File.directory?(f) }

      if has_variants
        load_variants(library_dir, library_name)
      else
        load_flat(library_dir, library_name)
      end
    end

    def load_variants(library_dir, library_name)
      Dir.glob(File.join(library_dir, "*")).each do |variant_dir|
        next unless File.directory?(variant_dir)

        load_variant(variant_dir, library_name)
      end
    end

    def load_variant(variant_dir, library_name)
      variant_name = File.basename(variant_dir).to_sym
      @icons[library_name][variant_name] = {}

      Dir.glob(File.join(variant_dir, "*.svg")).each do |file|
        icon_name = File.basename(file, ".svg").to_sym
        @icons[library_name][variant_name][icon_name] = File.read(file)
      end
    end

    def load_flat(library_dir, library_name)
      Dir.glob(File.join(library_dir, "*.svg")).each do |file|
        icon_name = File.basename(file, ".svg").to_sym
        @icons[library_name][icon_name] = File.read(file)
      end
    end
  end
end
