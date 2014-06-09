module Irradiated
  module Workers
    class TramTracker < Worker
      REFRESH_INTERVAL = 1.minute

      attr_reader :route_id, :stop_id

      private

      def parse_options(options)
        @route_id = options.delete('route_id')
        @stop_id = options.delete('stop_id')
      end

      def work
        save([storage_key, route_id, stop_id].to_json)
      end
    end
  end
end