# frozen_string_literal: true

require "thor"

module Ascona
  class CLI < Thor
    desc "download LIBRARY", "Download icons from a library"
    def download(library)
      puts "Downloading #{library} icons..."
    end
  end
end
