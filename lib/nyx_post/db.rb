require 'pg'
require 'active_record'
require 'securerandom'
require 'logger'

module NyxPost
  class DB
    def initialize
      @conn = ENV['DATABASE_URL'] ||= config
      @log = Logger.new(STDOUT)
    end

    def init
      ActiveRecord::Base.establish_connection(@conn)
      ActiveRecord::Base.logger = Logger.new(STDOUT)
      add_schema
    end

    # Set up model classes
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end

    class Post < ApplicationRecord
      validates :title, uniqueness: true
    end

    def get_id(id)
      Post.find(id)
    end

    def get_all
      posts = Post.all ||= [{ id: nil, title: nil, description: nil, created_at: nil }]
      my_posts = []
      posts.each { |p| my_posts << { id: p.id, title: p.title, description: p.description, created_at: "#{p.created_at}" }}
      @log.info(my_posts)
      my_posts
    end

    def create(title, desc)
      begin
        post = Post.new(title: title, description: desc, created_at: Time.now)
        if post.save
          { id: post.id, title: title, description: desc, created_at: "#{Time.now}" }
        else
          "Unable to create post #{title}"
        end
      rescue => e
        "Error: #{e}"
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
        enable_extension "pgcrypto"

        create_table "posts", id: :uuid, force: :cascade do |t|
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
