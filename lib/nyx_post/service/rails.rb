require 'proto/nyx_post_services_pb'

module NyxPost
  module Service
    class Rails < Nyx::PostService::Service

      # The method should match with Nyx::PostService::Service (rpc :GetPost, ...)
      def get_post(post_req, _unused_call)
        my_post = Post.find(post_req.id)
        Nyx::GetPostReply.new(post: my_post)
      end

      def get_posts(post_req, _unused_call)
        my_posts = Post.all
        Nyx::GetPostsReply.new(posts: my_posts)
      end

      def create(post_req, _unused_call)
        post = Post.new(post_req.title, post_req.description)
        if post.save
          msg = "New post created - title #{post_req.title} and desc #{post_req.description}"
        else
          msg = "Error to create post..."
        end
        Nyx::CreateReply.new(message: msg)
      end

      def delete(post_req, _unused_call)
        post = Post.find(post_req.id)
        if post
          post.destroy
          msg = "Successfully deleted."
        else
          msg = "Unable to delete post..."
        end
        Nyx::DeleteReply.new(message: msg)
      end
    end
  end
end
