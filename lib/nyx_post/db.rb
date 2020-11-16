require 'pg'
require 'active_record'

module NyxPost
  class DB
    def initialize
      @conn = ENV['DATABASE_URL'] ||= config
    end

    def init
      ActiveRecord::Base.establish_connection(@conn)
      add_schema
    end

    # Set up model classes
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end

    class Post < ApplicationRecord
    end

    def get_id(id)
      Post.find(id)
    end

    def get_all
      Post.all ||= []
    end

    def create(title, desc)
      post = Post.new(title, desc)
      if post.save
        "Added #{post}"
      else
        "Unable to create post #{title}"
      end
    end

    def destroy(id)
      begin
        post = Post.find(id)
        if post
          post.destroy
          "Post #{id} deleted"
        else
          "Post #{id} no found"
        end
      rescue => e
        "Error delete: #{e}"
      end
    end

    private

    def add_schema
      ActiveRecord::Schema.define do
        self.verbose = true # or false

        enable_extension "plpgsql"

        create_table "posts", force: :cascade do |t|
          t.string "title", null: false
          t.string "description", null: false
          t.datetime "created_at", precision: 6, null: false
        end
      end
    end

    def config
      user = "nyx-post"
      pass = "postgres"
      host = "127.0.0.1"
      port = 5432
      db = "nyx-post"
      "postgres://#{user}:#{pass}@#{host}:#{port}/#{db}?pool=5"
    end
  end
end
