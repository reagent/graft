module Graft
  module Model
    
    module ClassMethods
      
      def attributes
        @attributes ||= []
      end
      
      def attribute(name, options = {})
        self.attributes << Attribute.new(name, options[:from])
        class_eval "attr_accessor :#{name}"
      end

      def collection_from(xml, node)
        (Hpricot.XML(xml)/node).map {|n| new n.to_s }
      end
      
    end
    
    module InstanceMethods
      
      def initialize(document = nil)
        self.document = document
        self.populate_from(self.document) unless self.document.nil?
      end
      
      def document=(document)
        @document = document.is_a?(String) ? Hpricot.XML(document) : document
      end
      
      def document
        @document
      end
      
      def populate_from(document)
        self.class.attributes.each do |attribute|
          value = attribute.value_from(document)
          self.send("#{attribute.name}=".to_sym, value) unless value.nil?
        end
      end
      
    end
    
    def self.included(other)
      other.send(:extend, Graft::Model::ClassMethods)
      other.send(:include, Graft::Model::InstanceMethods)
    end
    
  end
end