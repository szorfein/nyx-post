require 'proto/nyx_post_services_pb'
require 'securerandom'

module NyxPost
  class NyxService < Nyx::PostService::Service

    def posts_list()
      # Hardcoded for now
      posts = [
        { id: '1', title: 'GPG Keys', description: 'Howto create a GPG Key with Tails Linux.' },
        { id: '2', title: 'Hardened Linux', description: 'Few tips to enhance security on Linux.' },
      ]
      posts
    end

    def check_post_id(id)
      # Hardcoded for now
      posts = [
        { id: '1', title: 'GPG Keys', description: 'Howto create a GPG Key with Tails Linux.' },
        { id: '2', title: 'Hardened Linux', description: 'Few tips to enhance security on Linux.' },
      ]
      if id == "1" || id == "2"
        posts[id]
      else
        raise "Article #{id} no found"
      end
    end

    # The method should match with Nyx::PostService::Service (rpc :GetPost, ...)
    def get_post(post_req, _unused_call)
      Nyx::GetPostReply.new(post: {
        id: "1",
        title: 'GPG Key',
        description: 'Howto create a GPG Key with Tails Linux.'
      })
    end

    def get_posts(post_req, _unused_call)
      Nyx::GetPostsReply.new(posts: posts_list)
    end

    def create(post_req, _unused_call)
      msg = "Received title #{post_req.title} and desc #{post_req.description}"
      Nyx::CreateReply.new(message: msg)
    end
  end
end
