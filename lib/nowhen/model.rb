require "data_mapper"
require "dm-sqlite-adapter"
require "nowhen/model/tag"
require "nowhen/model/log"
require "fileutils"

module NoWhen
  module Model
    def self.init(db_path=(ENV['NOWHEN_DB']||"#{ENV['HOME']}/.nowhen.sqlite"))
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

    def self.upgrade
      require 'dm-migrations'
      DataMapper.auto_upgrade!
    end
  end
end

NoWhen::Model.init
