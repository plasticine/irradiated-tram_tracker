module Irradiated
  module TramTracker
    class Worker < Irradiated::Workers::Worker
      REFRESH_INTERVAL = 1.minute

      attr_reader :route_id, :stop_id

      private

      def parse_options(options)
        @route_id = options.delete('route_id')
        @stop_id = options.delete('stop_id')
      end

      def work
        Service.current_schedule(route_id, stop_id)
      end
    end
  end
end
