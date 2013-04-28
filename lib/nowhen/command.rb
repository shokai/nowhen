require "nowhen"
require "args_parser"

module NoWhen
  module Command
    def self.show_help(parser)
        STDERR.puts "nowhen - Tagger for LifeLog v#{NoWhen::VERSION}"
        STDERR.puts "         https://github.com/shokai/nowhen"
        STDERR.puts parser.help
        STDERR.puts
        STDERR.puts "e.g."
        STDERR.puts "  % now yummy"
        STDERR.puts "  % when yummy"
    end

    def self.now(argv)
      parser = ArgsParser.parse argv do
        arg :version, 'show version', :alias => :v
        arg :help, 'show help', :alias => :h
      end
      if parser.has_option? :help
        show_help parser
      elsif parser.has_option? :version
        STDERR.puts "nowhen version #{NoWhen::VERSION}"
      elsif !parser.argv.empty?
        what = parser.argv[0].strip
        tag = NoWhen::Model::Tag.new(:what => what)
        tag.save
        puts tag
      else
        show_help parser
      end
    end

    def self.when(argv)
      parser = ArgsParser.parse argv do
        arg :version, 'show version', :alias => :v
        arg :help, 'show help', :alias => :h
      end
      if parser.has_option? :help
        show_help parser
      elsif parser.has_option? :version
        STDERR.puts "nowhen version #{NoWhen::VERSION}"
      else
        query = parser.argv.empty? ? {} : {:what => parser.argv[0].strip}
        tags = NoWhen::Model::Tag.find query
        tags.each do |tag|
          puts tag
        end
      end
    end

  end
end
