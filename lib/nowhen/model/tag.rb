module NoWhen
  module Model
    class Tag
      include DataMapper::Resource
      property :id, Serial
      property :created_at, Time, :default => lambda{|r,p| Time.now }
      property :updated_at, Time, :default => lambda{|r,p| Time.now }
      property :what, String, :required => true, :length => 0...256
      property :who, String, :length => 0...256, :default => lambda{|r,p| Time.now }
      property :latitude, Float
      property :longitude, Float
    end
  end
end
