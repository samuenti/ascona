# frozen_string_literal: true

require "net/http"
require "fileutils"
require "tmpdir"
require "rubygems/package"
require "zlib"

module Ascona
  module Library
    def self.available
      Dir.glob(File.join(__dir__, "libraries", "*.rb")).map do |f|
        File.basename(f, ".rb")
      end
    end

    def self.config_for(name)
      require_relative "libraries/#{name}"
      Ascona::Libraries.const_get(name.capitalize)::CONFIG
    end

    def self.download(name, destination)
      config = config_for(name)

      Dir.mktmpdir do |tmp_dir|
        tar_path = File.join(tmp_dir, "repo.tar.gz")
        download_tar(config[:repo], config[:branch], tar_path)
        extract_tar(tar_path, tmp_dir)
        copy_icons(tmp_dir, config[:path], destination)
      end
    end

    def self.download_tar(repo, branch, tar_path)
      uri = URI("https://github.com/#{repo}/archive/refs/heads/#{branch}.tar.gz")
      response = Net::HTTP.get_response(uri)
      response = Net::HTTP.get_response(URI(response["location"])) while response.is_a?(Net::HTTPRedirection)
      File.binwrite(tar_path, response.body)
    end

    def self.extract_tar(tar_path, tmp_dir)
      File.open(tar_path, "rb") do |file|
        Zlib::GzipReader.wrap(file) do |gz|
          Gem::Package::TarReader.new(gz) { |tar| extract_entries(tar, tmp_dir) }
        end
      end
    end

    def self.extract_entries(tar, tmp_dir)
      tar.each do |entry|
        next unless entry.file?

        path = File.join(tmp_dir, entry.full_name)
        FileUtils.mkdir_p(File.dirname(path))
        File.binwrite(path, entry.read)
      end
    end

    def self.copy_icons(tmp_dir, icons_path, destination)
      extracted_dir = Dir.glob(File.join(tmp_dir, "*")).find { |f| File.directory?(f) }
      source = File.join(extracted_dir, icons_path)

      FileUtils.mkdir_p(destination)
      Dir.glob(File.join(source, "*.svg")).each do |svg|
        FileUtils.cp(svg, destination)
      end
    end

    private_class_method :download_tar, :extract_tar, :extract_entries, :copy_icons
  end
end
