# frozen_string_literal: true

module Ascona
  module Helper
    def icon(name, library: nil, variant: nil, **attributes)
      library ||= Ascona.configuration.default_library
      raise ArgumentError, "No library specified and no default set" unless library

      variant ||= Ascona.configuration.default_variants[library.to_sym]
      svg = Ascona.registry.get(name.to_sym, library: library.to_sym, variant: variant)
      raise ArgumentError, "Icon '#{name}' not found in library '#{library}'" unless svg

      svg = inject_attributes(svg, attributes) unless attributes.empty?
      svg.html_safe
    end

    private

    def inject_attributes(svg, attributes)
      attrs_string = attributes.map { |k, v| %(#{k.to_s.gsub("_", "-")}="#{v}") }.join(" ")
      svg.sub("<svg", "<svg #{attrs_string}")
    end
  end
end
