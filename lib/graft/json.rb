$:.unshift File.dirname(__FILE__) + '/..'

require 'json'

require 'graft/model'
require 'graft/json/attribute'
require 'graft/json/model'

module Graft
  def self.included(other)
    other.send(:include, Graft::Json::Model)
  end
end