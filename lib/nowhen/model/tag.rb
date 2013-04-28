module NoWhen
  module Model
    class Tag
      include DataMapper::Resource
      property :id, Serial
      timestamps :at
      property :what, String, :required => true, :length => 0...256
      property :who, String, :length => 0...256, :default => lambda{|r,p| `whoami`.strip }
      property :latitude, Float
      property :longitude, Float

      def self.find(query={})
        {:order => [:created_at.asc], :limit => 40}.each do |k,v|
          query[k] = v unless query.include? k
        end
        self.all query
      end

      def logs(minute=5)
        rational = Rational(1, 24*60/minute)
        Log.find :created_at => (self.created_at-rational)..(self.created_at+rational)
      end

      def to_s
        "[#{self.what}]\t#{self.created_at.strftime '(%m/%d %a %H:%M:%S)'}"
      end
    end
  end
end
