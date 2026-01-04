# frozen_string_literal: true

module Ascona
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def copy_initializer
        copy_file "initializer.rb", "config/initializers/ascona.rb"
      end
    end
  end
end
