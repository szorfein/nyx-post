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
      Post.new(title, desc)
    end

    def destroy(id)
      post = find(id)
      if post
        Post.destroy(post)
      else
        puts "Post #{id} no found"
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
