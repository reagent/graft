require File.dirname(__FILE__) + '/../test_helper'

module Graft
  class JsonAttributeTest < Test::Unit::TestCase
    
    context "An instance of the JsonAttribute class" do
      
      should "know its name" do
        attr = JsonAttribute.new(:foo)
        attr.name.should == :foo
      end
      
      should "have a default source" do
        attr = JsonAttribute.new(:foo)
        attr.source.should == 'foo'
      end
      
      should "be able to extract a value from a JSON string" do
        data = '{ "first_name": "Richerd" }'
        
        attr = JsonAttribute.new(:first_name)
        attr.value_from(data).should == 'Richerd'
      end
      
      should "be able to extract a nested value from a JSON string" do
        data = '{ "user": {"first_name": "Richerd"} }'
        
        attr = JsonAttribute.new(:first_name, 'user/first_name')
        attr.value_from(data).should == 'Richerd'
      end
      
      should "return nil when the value doesn't exist" do
        data = '{ "first_name": "Richerd" }'
        
        attr = JsonAttribute.new(:last_name, 'last_name')
        attr.value_from(data).should be(nil)
      end
      
    end
    
  end
end