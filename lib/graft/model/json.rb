module Graft
  module Model
    module Json

      module ClassMethods

        def attribute(name, options = {})
          source = options[:from]

          self.attributes << JsonAttribute.new(name, source)
          class_eval "attr_accessor :#{name}"
        end

      end

      module InstanceMethods

        def initialize(json_data = nil)
          self.populate_from(json_data) unless json_data.nil?
        end

      end

      def self.included(other)
        other.send(:extend, Graft::Model::ClassMethods)
        other.send(:extend, Graft::Model::Json::ClassMethods)
        other.send(:include, Graft::Model::InstanceMethods)
        other.send(:include, Graft::Model::Json::InstanceMethods)
      end

    end
  end
end