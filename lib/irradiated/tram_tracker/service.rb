require 'handsoap'
require 'curb'

module Irradiated
  module TramTracker
    class Service < Handsoap::Service
      CLIENT_TYPE = 'TRAMHUNTER'
      TRAM_TRACKER_ENDPOINT = {
        uri: 'http://ws.tramtracker.com.au/pidsservice/pids.asmx',
        version: 2
      }

      endpoint TRAM_TRACKER_ENDPOINT

      def current_schedule(route_id, stop_no, low_floor = false)
        response = call_get_next_predicted_routes_collection(route_id, stop_no, low_floor)
        response.document.xpath('//ToReturn').map do |node|
          parse_schedule_node(node)
        end
      end

      private

      def call_get_next_predicted_routes_collection(route_id, stop_no, low_floor)
        invoke('GetNextPredictedRoutesCollection', soap_action: nil) do |message|
          message.set_attr 'xmlns',    'http://www.yarratrams.com.au/pidsservice/'
          message.add      'stopNo',   stop_no
          message.add      'routeNo',  route_id
          message.add      'lowFloor', low_floor
        end
      end

      def ns
        { ns: 'http://www.yarratrams.com.au/pidsservice/' }
      end

      def on_create_document(doc)
        doc.find('Header').add 'PidsClientHeader' do |node|
          client_header(node)
        end
      end

      def client_header(node)
        node.set_attr 'xmlns', 'http://www.yarratrams.com.au/pidsservice/'
        node.add 'ClientType', CLIENT_TYPE
        node.add 'ClientVersion', '1.0.0.0'
        node.add 'ClientWebServiceVersion', '6.4.0.0'
        node.add 'OSVersion', '1.0.0.0'
      end

      def parse_schedule_node(node)
        {
          destination:         xml_to_str(node,  './Destination/text()'),
          hasDisruption:       xml_to_bool(node, './HasDisruption/text()'),
          hasSpecialEvent:     xml_to_bool(node, './HasSpecialEvent/text()'),
          specialEventMessage: xml_to_str(node,  './SpecialEventMessage/text()'),
          arrivalTime:         xml_to_date(node, './PredictedArrivalDateTime/text()')
        }
      end
    end
  end
end
