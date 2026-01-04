# frozen_string_literal: true

require "thor"
require_relative "library"

module Ascona
  class CLI < Thor
    desc "list", "List available icon libraries"
    def list
      libraries = Library.available
      if libraries.empty?
        puts "No libraries available"
      else
        puts "Available libraries:"
        libraries.each { |lib| puts "  - #{lib}" }
      end
    end

    desc "download LIBRARY", "Download icons from a library"
    def download(library)
      unless Library.available.include?(library)
        puts "Unknown library: #{library}"
        puts "Run 'ascona list' to see available libraries"
        return
      end

      destination = File.join(Ascona.configuration.icon_path, library)
      puts "Downloading #{library} icons to #{destination}..."
      Library.download(library, destination)
      puts "Done!"
    end
  end
end
