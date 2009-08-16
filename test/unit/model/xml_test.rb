require File.dirname(__FILE__) + '/../../test_helper'

class EmptyXmlModel
  include Graft::Model::Xml
end

class XmlModelWithAttributes
  include Graft::Model::Xml

  attribute :name
  attribute :description, :from => 'desc'
  attribute :rating,      :from => 'rating@value'
  attribute :size,        :from => "node[@type='size']@value"
  
end

class XmlModelWithAttributeType
  include Graft::Model::Xml
  
  attribute :id, :type => :integer
end

class XmlModelTest < Test::Unit::TestCase

  context "The EmptyXmlModel class" do
    should "have an empty list of attributes if none are supplied" do
      EmptyXmlModel.attributes.should == []
    end
    
    should "be able to return a collection of XML nodes" do
      xml =<<-XML
        <?xml version="1.0" encoding="UTF-8"?>
        <things>
          <thing><id>1</id></thing>
          <thing><id>2</id></thing>
        </things>
      XML
      
      EmptyXmlModel.expects(:new).with('<thing><id>1</id></thing>').returns('model_1')
      EmptyXmlModel.expects(:new).with('<thing><id>2</id></thing>').returns('model_2')
      
      collection = EmptyXmlModel.collection_from(xml, 'things/thing')
      collection.should == ['model_1', 'model_2']
    end
    
    should "return an empty hash when calling :to_hash" do
      m = EmptyXmlModel.new
      m.to_hash.should == {}
    end

  end
  
  context "The XmlModelWithAttributes class" do
    should "know the names of all its attributes" do
      XmlModelWithAttributes.attributes.map {|a| a.name.to_s }.should == %w(name description rating size)
    end
    
    should "return a hash representation of itself" do
      m = XmlModelWithAttributes.new
      
      m.name        = 'name'
      m.description = 'description'
      m.rating      = '5'
      m.size        = 'large'
    
      m.to_hash.should == {
        'name'        => 'name',
        'description' => 'description',
        'rating'      => '5',
        'size'        => 'large'
      }

    end
  end
  
  context "The ModelWithAttributeType class" do
    should "know that it's attribute is of type :integer" do
      attribute = XmlModelWithAttributeType.attributes.first
      attribute.type_class.should == Graft::Type::Integer
    end
    
    should "be able to generate an XML representation of itself" do
      
      m = XmlModelWithAttributeType.new
      m.id = 1
      
      xml = String.new
      xml << '<?xml version="1.0" encoding="UTF-8"?>'
      xml << '<model>'
      xml << '<id>1</id>'
      xml << '</model>'
      
      m.to_xml('model').should == xml
      
    end
  end

  context "An instance of the XmlModelWithAttributes class" do

    setup { @simple_xml = '<name>Graft</name>' }

    should "have default reader method for :name" do
      XmlModelWithAttributes.new.respond_to?(:name).should be(true)
    end
    
    should "be able to populate its data on initialization" do
      xml = Hpricot.XML(@simple_xml)
      XmlModelWithAttributes.new(xml).name.should == 'Graft'
    end
    
    should "have a reference to the original document" do
      xml = Hpricot.XML(@simple_xml)
      XmlModelWithAttributes.new(xml).document.should == xml
    end
    
    should "be able to populate from an XML string" do
      XmlModelWithAttributes.new(@simple_xml).name.should == 'Graft'
    end
    
    context "when populating data from an XML document" do
      
      setup do
        xml = <<-XML
          <name>Graft</name>
          <desc>A sweet Ruby library</desc>
          <rating value="100" />
          <node type="color" value="blue" />
          <node type="size" value="large" />
        XML

        @model = XmlModelWithAttributes.new
        @model.populate_from(Hpricot.XML(xml))
      end

      should "have the correct value for :name" do
        @model.name.should == 'Graft'
      end
      
      should "have the correct value for :description" do
        @model.description.should == 'A sweet Ruby library'
      end
      
      should "have the correct value for :rating" do
        @model.rating.should == '100'
      end
      
      # should "have the correct value for :size" do
      #   @model.size.should == 'large'
      # end
      
    end
  end
  
end