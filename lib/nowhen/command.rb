require "nowhen"
require "args_parser"

module NoWhen
  module Command
    def self.now(argv)
      argv.each do |what|
        tag = NoWhen::Model::Tag.new(:what => what)
        tag.save
      end
    end
  end
end
