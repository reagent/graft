require File.dirname(__FILE__) + '/../../test_helper'

class EmptyJsonModel
  include Graft::Model::Json
end

class JsonModelWithAttributes
  include Graft::Model::Json

  attribute :name
  attribute :description, :from => 'desc'
  attribute :rating,      :from => 'rsp/rating'
end

class JsonModelTest < Test::Unit::TestCase

  context "The EmptyModel class" do
    should "have an empty list of attributes if none are supplied" do
      EmptyJsonModel.attributes.should == []
    end
  end

  context "The ModelWithAttributes class" do
    should "know the names of all its attributes" do
      JsonModelWithAttributes.attributes.map {|a| a.name.to_s }.should == %w(name description rating)
    end
  end
  
  context "An instance of the ModelWithAttributes class" do
    
    should "assign attributes upon initialization" do
      json_data = '{"name":"Graft"}'
      JsonModelWithAttributes.new(json_data).name.should == 'Graft'
    end
    
    context "when populating from JSON data" do
      setup do
        json_data = '{"name":"Graft", "desc":"library", "rsp":{"rating":10}}'
        @model = JsonModelWithAttributes.new
        @model.populate_from(json_data)
      end

      should "have a value for :name" do
        @model.name.should == 'Graft'
      end

      should "have a value for :description" do
        @model.description.should == 'library'
      end

      should "have a value for :rating" do
        @model.rating.should == 10
      end
    end
    
  end
  
end