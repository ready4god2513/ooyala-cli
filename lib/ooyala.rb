require 'ooyala/version.rb'
require 'ooyala-v2-api'
require 'ooyala/live_stream.rb'

module Ooyala

  class Config

    @@file = File.join(File.dirname(File.expand_path(File.dirname(__FILE__))), 'keys.yml')

    def self.fetch(name)
      @config ||= YAML.load_file(@@file)
      @config[name] if @config
    end

    def self.set(name, val)
      data = YAML.load_file(@@file) || Hash.new
      data[name] = val
      File.open(@@file, "w") { |f| YAML.dump(data, f) }
    end

  end

end