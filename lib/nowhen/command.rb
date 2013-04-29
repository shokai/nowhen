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
        STDERR.puts "  % now -log http://example.com/delicious_food_recipe"
        STDERR.puts "  % when yummy"
    end

    def self.now(argv)
      parser = ArgsParser.parse argv do
        arg :log, 'save log'
        arg :db_upgrade, 'upgrade database'
        arg :version, 'show version', :alias => :v
        arg :help, 'show help', :alias => :h
      end
      if parser.has_option? :help
        show_help parser
      elsif parser.has_option? :version
        STDERR.puts "nowhen version #{NoWhen::VERSION}"
      elsif parser.has_option? :db_upgrade
        NoWhen::Model.upgrade
      elsif parser[:log]
        log = parser.has_param?(:log) ? parser[:log] : parser.argv.join(' ')
        log = NoWhen::Model::Log.new(:log => log)
        log.save
        puts log.log
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
        arg :limit, 'tags count', :default => 40
        arg :all, 'disable tag count limit'
        arg :version, 'show version', :alias => :v
        arg :help, 'show help', :alias => :h
      end
      if parser.has_option? :help
        show_help parser
      elsif parser.has_option? :version
        STDERR.puts "nowhen version #{NoWhen::VERSION}"
      else
        query = {}
        query[:what] = parser.argv[0].strip unless parser.argv.empty?
        query[:limit] = parser[:limit] unless parser.has_option? :all
        tags = NoWhen::Model::Tag.find query
        tags.each do |tag|
          puts tag
          tag.logs.each do |log|
            puts " - #{log.log}"
          end
        end
      end
    end
  end
end
