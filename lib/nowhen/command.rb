require "nowhen"
require "args_parser"

module NoWhen
  module Command
    def self.now(argv)
      parser = ArgsParser.parse argv do
        arg :when, 'search tags'
        arg :version, 'show version', :alias => :v
        arg :help, 'show help', :alias => :h
      end
      if parser.has_option? :help
        STDERR.puts "nowhen - Tagger for LifeLog v#{NoWhen::VERSION}"
        STDERR.puts "         https://github.com/shokai/nowhen"
        STDERR.puts parser.help
        STDERR.puts
        STDERR.puts "e.g."
        STDERR.puts "  % now yummy"
        STDERR.puts "  % when yummy"
      elsif parser.has_option? :version
        STDERR.puts "nowhen version #{NoWhen::VERSION}"
      elsif parser.has_param? :when
      elsif !parser.argv.empty?
        what = parser.argv[0]
        tag = NoWhen::Model::Tag.new(:what => what)
        tag.save
        puts "tagged \"#{what}\" at #{tag.created_at}"
      end
    end
  end
end
