$:.unshift File.dirname(__FILE__) + '/..'

require 'hpricot'
require 'builder'
require 'tzinfo'

begin
  # ActiveSupport < 2.3.5
  require 'active_support/core_ext/blank'
rescue NameError
  # ActiveSupport >= 2.3.5 will raise a NameError exception
  require 'active_support/core_ext/object/blank'
end

require 'active_support/time_with_zone'
require 'active_support/inflector'

require 'graft/model'
require 'graft/xml/type'
require 'graft/xml/attribute'
require 'graft/xml/model'

module Graft
  def self.included(other)
    other.send(:include, Graft::Xml::Model)
  end
end