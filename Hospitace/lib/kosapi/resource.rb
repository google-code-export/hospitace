
module KOSapi
  class Resource
    def self.attrs_with_translate(*args)
      attr_reader *args 
      
      args.each do |attribute|
        define_method "#{attribute}_t" do
          value = self.send(attribute)
          value = value.first if value.is_a?(Array)
          scope = self.class.name.demodulize.downcase
          I18n.t value, :scope=>".#{scope}.#{attribute}", :default=>value
        end
      end
    end
    
    private
      def valid? data
        if data.nil? or data['@id'].nil? or data['@uri'].nil? then
          false
        else
          true
        end
      end
      
      def convert_users user
        return Array[] if user.nil?
        users = user['person']
        return Array[] if users.nil?
        if users.kind_of? Hash then
          Array[User.new users]
        else
          users.collect {|user| User.new user}
        end
      end
    
      def self.get(uri)
        begin
          RestClient.enable Rack::CommonLogger, STDOUT
          RestClient.enable Rack::Cache,
            :verbose     => true,
            :metastore   => "file:#{File.dirname(__FILE__)}/../../tmp/cache/rack/meta",
            :entitystore => "file:#{File.dirname(__FILE__)}/../../tmp/cache/rack/body",
            :default_ttl => 36000 # cache will live 10 hour
          response = RestClient.get uri, :accept => "application/json"
          Yajl::Parser.parse(response.body) if response.code == 200
        rescue RestClient::ResourceNotFound
          puts "Error getting " + uri
        rescue RestClient::Exception => e
          puts "Exception in RestClient => #{e.to_s}"
        end
      end
  end
end