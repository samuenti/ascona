# frozen_string_literal: true

require "thor"

module Ascona
  class CLI < Thor
    def self.available_libraries
      Dir.glob(File.join(__dir__, "libraries", "*.rb")).map do |f|
        File.basename(f, ".rb")
      end
    end

    desc "list", "List available icon libraries"
    def list
      libraries = self.class.available_libraries
      if libraries.empty?
        puts "No libraries available"
      else
        puts "Available libraries:"
        libraries.each { |lib| puts "  - #{lib}" }
      end
    end

    desc "download LIBRARY", "Download icons from a library"
    def download(library)
      unless self.class.available_libraries.include?(library)
        puts "Unknown library: #{library}"
        puts "Run 'ascona list' to see available libraries"
        return
      end

      puts "Downloading #{library} icons..."
    end
  end
end
