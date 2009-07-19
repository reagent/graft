require File.dirname(__FILE__) + '/../test_helper'

class EmptyModel
  include Graft::Model
end

class ModelWithAttributes
  include Graft::Model

  attribute :name
  attribute :description, :from => 'desc'
  attribute :rating,      :from => 'rating@value'
  attribute :size,        :from => "node[@type='size']@value"
  
end

class ModelTest < Test::Unit::TestCase

  context "The EmptyModel class" do
    should "have an empty list of attributes if none are supplied" do
      EmptyModel.attributes.should == []
    end
    
    should "be able to return a collection of XML nodes" do
      xml =<<-XML
        <?xml version="1.0" encoding="UTF-8"?>
        <things>
          <thing><id>1</id></thing>
          <thing><id>2</id></thing>
        </things>
      XML
      
      collection = EmptyModel.collection_from(xml, 'things/thing')
      collection.should == %w(<thing><id>1</id></thing> <thing><id>2</id></thing>)
    end

  end

  context "The ModelWithAttributes class" do
    should "know the names of all its attributes" do
      ModelWithAttributes.attributes.map {|a| a.name.to_s }.should == %w(name description rating size)
    end
  end

  context "An instance of the ModelWithAttributes class" do

    setup { @simple_xml = '<name>Graft</name>' }

    should "have default reader method for :name" do
      ModelWithAttributes.new.respond_to?(:name).should be(true)
    end
    
    should "be able to populate its data on initialization" do
      xml = Hpricot.XML(@simple_xml)
      ModelWithAttributes.new(xml).name.should == 'Graft'
    end
    
    should "have a reference to the original document" do
      xml = Hpricot.XML(@simple_xml)
      ModelWithAttributes.new(xml).document.should == xml
    end
    
    should "be able to populate from an XML string" do
      ModelWithAttributes.new(@simple_xml).name.should == 'Graft'
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

        @model = ModelWithAttributes.new
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