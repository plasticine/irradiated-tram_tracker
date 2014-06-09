module Irradiated
  module Views
    class TramTracker < View
      def test_value
        Irradiated.adapter.get(storage_key)
      end

      private

      def worker
        Irradiated::Workers::TramTracker
      end

      def to_builder
        Jbuilder.new do |tram|
          person.(self, :name, :age)
        end
      end

      def storage_key
        super(@route_id, @stop_id)
      end

      def parse_options(options)
        @route_id = options.delete(:route_id)
        @stop_id = options.delete(:stop_id)
      end
    end
  end
end