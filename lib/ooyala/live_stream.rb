require 'socket'

module Ooyala

  class LiveStream

    attr_reader :result

    def initialize(api, options = {})
      @api = api
      @options = options.merge({
        asset_type: "live_stream",
        is_flash: true,
        is_ios: true,
        primary_encoder_ip: UDPSocket.open {|s| s.connect("64.233.187.99", 1); s.addr.last}
      })
    end

    # Transforms encodings as a string (1280:720:800;1280:720:1500;1280:720:2500;)
    # to their final required format- 
    # [
    #   { "width": 800, "height": 600, "bitrate": 600 }, 
    #   { "width": 800, "height": 600, "bitrate": 300 }, 
    #   { "width": 400, "height": 300, "bitrate": 200 }
    # ] - See more at: http://support.ooyala.com/developers/documentation/api/asset_livestream.html#sthash.7v0KBwAI.dpuf
    def encodings=(enc)
      formatted = enc.split(";").map {|i| i.split(":") }.map { |item| { width: item.shift, height: item.shift, bitrate: item.shift } }
      @options[:encodings] = formatted
    end

    def publish
      @result = @api.post('assets', @options)
      @result
    end

  end

end