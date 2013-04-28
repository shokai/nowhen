require "data_mapper"
require "dm-sqlite-adapter"
require "nowhen/model/tag"
require "fileutils"

module NoWhen
  module Model
    def self.init(db_path="#{ENV['HOME']}/.nowhen.sqlite")
      FileUtils.mkdir_p File.dirname(db_path) unless File.exists? File.dirname(db_path)
      DataMapper.setup(:default, {:adapter => :sqlite, :database => db_path})
      DataMapper::Logger.new($stdout, :debug)
      migrate unless File.exists? db_path
      DataMapper.finalize
    end

    def self.migrate
      require 'dm-migrations'
      DataMapper.auto_migrate!
    end
  end
end

NoWhen::Model.init
