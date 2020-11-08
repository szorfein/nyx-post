require 'proto/nyx_post_services_pb'

module NyxPost
  class NyxService < Nyx::Post::Service
    # The method should match with Nyx::Post::Service (rpc :Get, ...)
    def get(post_req, _unused_call)
      msg = "Received title #{post_req.title} and desc #{post_req.description}"
      Nyx::GetReply.new(message: msg)
    end
  end
end
