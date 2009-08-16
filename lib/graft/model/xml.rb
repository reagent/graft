module Graft
  module Model
    module Xml

      module ClassMethods

        def attribute(name, options = {})
          source = options[:from]
          type   = options[:type] || :string

          self.attributes << XmlAttribute.new(name, type, source)
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

        def to_hash
          self.class.attributes.inject({}) {|h,a| h.merge(a.name.to_s => send(a.name)) }
        end

        def to_xml(tag_name)
          xml = Builder::XmlMarkup.new
          xml.instruct!
          xml.tag! tag_name do
            to_hash.each do |attribute, value|
              xml.tag! attribute, value
            end
          end
          xml.target!
        end


      end

      def self.included(other)
        other.send(:extend, Graft::Model::ClassMethods)
        other.send(:extend, Graft::Model::Xml::ClassMethods)
        other.send(:include, Graft::Model::InstanceMethods)
        other.send(:include, Graft::Model::Xml::InstanceMethods)
      end

    end
  end
end