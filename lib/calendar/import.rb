require 'soda/client'
require 'fileutils'
require 'yaml'
require 'HTTParty'

module Calendar
  class Import

    class << self
      def import(config)
        results = HTTParty.get('https://accdcalendar.blob.core.windows.net/webevents/calendarevents.json?sp=racwd&st=2023-01-11T17:01:55Z&se=2024-01-12T01:01:55Z&spr=https&sv=2021-06-08&sr=b&sig=mBEYw1CkQoFCkrqpszTDczkgCkpRufHb%2FRInV%2F%2FtKZY%3D')
        path = File.join(config["source"], config["data_dir"], "socrata", "events", "events.yaml")

        FileUtils.mkdir_p(File.dirname(path))

        File.open(path, "w") do |file|
          file.write(YAML.dump(JSON.parse(results).map(&:to_hash)))
        end
      end

    end

  end
end
