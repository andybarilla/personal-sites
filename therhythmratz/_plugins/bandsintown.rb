require 'json'
require 'hash-joiner'
require 'open-uri'
require 'uri'

module Bandsintown
  class Generator < Jekyll::Generator
    def generate(site)
      config = site.config['bandsintown']
      if !config
        return
      end
      if !config['bands'].kind_of?(Array)
        config['bands'] = [config['bands']]
      end
      bitevents = nil
      uri = "http://api.bandsintown.com/artists/%s/events.json?app_id=jekyll_bit_plugin&api_version=2.0"

      config['bands'].each do |d|
        # begin
          band_name = URI.encode(d)
          source = JSON.load(open(uri % [band_name]))
          if bitevents
            HashJoiner.deep_merge bitevents, source
          else
            bitevents = source
          end
        #rescue
        #  next
        #end
      end

      bitevents.each do |gig|
        artists = []
        if config['strftime']
          gig['strftime'] = DateTime.parse(gig['datetime']).strftime(config['strftime'])
        end
        gig['artists'].each do |artist|
          artists << artist['name']
        end
        gig['artistlist'] = artists.join(', ')
      end

      site.data['bitevents'] = bitevents.sort_by { |k| DateTime.parse(k['datetime']) }
    end
  end
end