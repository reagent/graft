module Graft
  module Json
    module Model

      module ClassMethods

        def attribute(name, options = {})
          source = options[:from]

          self.attributes << Graft::Json::Attribute.new(name, source)
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
        other.send(:extend, Graft::Json::Model::ClassMethods)
        other.send(:include, Graft::Model::InstanceMethods)
        other.send(:include, Graft::Json::Model::InstanceMethods)
      end

    end
  end
end