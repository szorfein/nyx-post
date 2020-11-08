require 'grpc'
require 'proto/nyx_post_services_pb'

module NyxPost
  class Client
    def initialize(title, desc)
      @title = title
      @desc = desc
    end

    def start
      stub = Nyx::Post::Stub.new('0.0.0.0:50052', :this_channel_is_insecure)
      begin
        message = stub.get(Nyx::GetRequest.new(title: @title, description: @desc)).message
        puts "Msg: #{message}"
      rescue GRPC::BadStatus => e
        abort "ERROR: #{e.message}"
      end
    end
  end
end
