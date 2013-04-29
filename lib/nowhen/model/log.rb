module NoWhen
  module Model
    class Log
      include DataMapper::Resource
      property :id, Serial
      timestamps :at
      property :log, String, :required => true, :length => 0...2048

      def self.find(query={})
        {:order => [:created_at.asc]}.each do |k,v|
          query[k] = v unless query.include? k
        end
        self.all query
      end
    end
  end
end
