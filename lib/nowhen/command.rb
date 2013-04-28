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
        tags = NoWhen::Model::Tag.find :what => parser[:when]
        tags.each do |tag|
          puts tag
        end
      elsif !parser.argv.empty?
        what = parser.argv[0].strip
        tag = NoWhen::Model::Tag.new(:what => what)
        tag.save
        puts "tagged \"#{what}\" -> #{tag.created_at}"
      else
        STDERR.puts "argument error!"
      end
    end
  end
end
