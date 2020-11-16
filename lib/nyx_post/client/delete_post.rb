require 'grpc'
require 'proto/nyx_post_services_pb'

module NyxPost
  module Client
    class DeletePost
      def initialize(id)
        @id = id
        @stub = Nyx::PostService::Stub.new('0.0.0.0:50052', :this_channel_is_insecure)
      end

      def start
        begin
          @stub.delete(Nyx::DeleteRequest.new(id: @id)).message
        rescue GRPC::BadStatus => e
          abort "ERROR: #{e.message}"
        end
      end
    end
  end
end
