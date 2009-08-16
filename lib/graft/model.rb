module Graft
  module Model

    module ClassMethods
      def attributes
        @attributes ||= []
      end
    end

    module InstanceMethods
      
      def populate_from(data_source)
        self.class.attributes.each do |attribute|
          value = attribute.value_from(data_source)
          self.send("#{attribute.name}=".to_sym, value) unless value.nil?
        end
      end
      
    end
    
  end
end