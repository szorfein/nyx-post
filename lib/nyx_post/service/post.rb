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

      def create(post_req, _unused_call)
        title = post_req.title
        desc = post_req.description
        post = NyxPost::DB.new.create(title, desc)
        if post.save
          msg = "Create title #{post_req.title} and desc #{post_req.description}"
        else
          msg = "Fail to create post"
        end
        Nyx::CreateReply.new(message: msg)
      end

      def delete(post_req, _unused_call)
        msg = "Post #{post_req.id} deleted"
        Nyx::DeleteReply.new(message: msg)
      end
    end
  end
end
