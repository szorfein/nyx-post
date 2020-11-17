require 'proto/nyx_post_services_pb'

module NyxPost
  module Client
    class CreatePost
      def initialize(title, desc)
        @title = title
        @desc = desc
        @stub = Nyx::PostService::Stub.new('0.0.0.0:50052', :this_channel_is_insecure)
      end

      def start
        begin
          @stub.create_post(Nyx::CreateRequest.new(title: @title, description: @desc)).post
        rescue GRPC::BadStatus => e
          abort "ERROR: #{e.message}"
        end
      end
    end
  end
end
