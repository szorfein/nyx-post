require 'proto/nyx_post_services_pb'

module NyxPost
  module Service
    class Demo < Nyx::PostService::Service

      # The method should match with Nyx::PostService::Service (rpc :GetPost, ...)
      def get_post(post_req, _unused_call)
        # Find by id, just hardcoded for the example
        my_post = { id: '1', title: 'GPG Keys', description: 'Howto create a GPG Key with Tails Linux.' }
        Nyx::GetPostReply.new(post: my_post)
      end

      def get_posts(post_req, _unused_call)
        my_posts = [
          { id: '1', title: 'GPG Keys', description: 'Howto create a GPG Key with Tails Linux.' },
          { id: '2', title: 'Hardened Linux', description: 'Few tips to enhance security on GNU/Linux.' },
          { id: '3', title: 'Ruby', description: 'Some advantages for Ruby.' }
        ]
        Nyx::GetPostsReply.new(posts: my_posts)
      end

      def create(post_req, _unused_call)
        msg = "Create title #{post_req.title} and desc #{post_req.description}"
        Nyx::CreateReply.new(message: msg)
      end

      def delete(post_req, _unused_call)
        msg = "Post #{post_req.id} deleted"
        Nyx::DeleteReply.new(msg_err: msg)
      end
    end
  end
end
