require 'grpc'
require 'proto/nyx_post_services_pb'
require 'json'

module NyxPost
  module Client
    class GetPost
      def initialize
        @stub = Nyx::PostService::Stub.new('0.0.0.0:50052', :this_channel_is_insecure)
      end

      def by_id(id)
        begin
          post = @stub.get_post(Nyx::GetPostRequest.new(id: "1")).post
          puts post.to_json
        rescue GRPC::BadStatus => e
          abort "ERROR: #{e.message}"
        end
      end

      def all(skip, take)
        begin
          posts = @stub.get_posts(Nyx::GetPostsRequest.new(skip: skip, take: take)).posts
          puts posts.to_json
        rescue GRPC::BadStatus => e
          abort "ERROR: #{e.message}"
        end
      end
    end
  end
end
