require 'proto/nyx_post_services_pb'

module Services
  class NyxService < Nyx::Post::Service
    # The method should match with Nyx::Post::Service (rpc :Get, ...)
    def get(post_req, _unused_call)
      #puts "Received title #{post_req.title} and desc #{post_req.description}"
      Nyx::GetReply.new(message: "#{post_req.title} #{post_req.description}")
    end
  end
end
