require 'proto/nyx_post_services_pb'

module NyxPost
  module Service
    class Post < Nyx::PostService::Service

      # The method should match with Nyx::PostService::Service (rpc :GetPost, ...)
      def get_post(post_req, _unused_call)
        # Find by id, just hardcoded for the example
        my_post = { id: '1', title: 'GPG Keys', description: 'Howto create a GPG Key with Tails Linux.' }
        Nyx::GetPostReply.new(post: my_post)
      end

      def get_posts(post_req, _unused_call)
        my_posts = NyxPost::DB.new.get_all
        Nyx::GetPostsReply.new(posts: my_posts)
      end

      def create_post(post_req, _unused_call)
        post = NyxPost::DB.new.create(post_req.title, post_req.description)
        Nyx::CreateReply.new(post: post)
      end

      def delete(post_req, _unused_call)
        msg = NyxPost::DB.new.destroy(post_req.id)
        Nyx::DeleteReply.new(message: msg)
      end
    end
  end
end
