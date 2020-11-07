require 'grpc'
require 'proto/nyx_post_services_pb'
require 'services'

module Client
  def self.start
    stub = Nyx::Post::Stub.new('0.0.0.0:50052', :this_channel_is_insecure)
    begin
      message = stub.get(Nyx::GetRequest.new(title: "GPG Keys", description: "HOWTO create a GPG Keys on Tails linux")).message
      puts "Msg: #{message}"
    rescue GRPC::BadStatus => e
      abort "ERROR: #{e.message}"
    end
  end
end
