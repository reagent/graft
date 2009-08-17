module Graft
  module Model

    module ClassMethods
      def attributes
        @attributes ||= []
      end
    end

    module InstanceMethods
      
      def initialize(source_data = nil)
        self.source_data = source_data
        self.populate_from(self.source_data) unless self.source_data.nil?
      end
      
      def source_data=(source_data)
        @source_data = self.class.data_from(source_data)
      end
      
      def source_data
        @source_data
      end
      
      def populate_from(data_source)
        self.class.attributes.each do |attribute|
          value = attribute.value_from(data_source)
          self.send("#{attribute.name}=".to_sym, value) unless value.nil?
        end
      end
      
    end
    
  end
end