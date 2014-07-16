module Irradiated
  module TramTracker
    class View < Irradiated::Views::View
      attr_reader :route_id, :stop_id

      def key
        super(route_id, stop_id)
      end

      private

      def worker
        Irradiated::TramTracker::Worker
      end

      def parse_options(options)
        @route_id = options.delete(:route_id)
        @stop_id = options.delete(:stop_id)
      end
    end
  end
end
