module Graft
  class JsonAttribute
    
    attr_reader :name, :source
    
    def initialize(name, source = nil)
      @name   = name
      @source = source.nil? ? @name.to_s : source
    end
    
    def value_from(data)
      json_data = JSON.parse(data)
      
      source.split('/').inject(json_data) do |data, key|
        (data.is_a?(Hash) && data[key]) ? data[key] : nil
      end
    end
    
  end
end