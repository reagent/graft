$:.unshift File.dirname(__FILE__) + '/..'

require 'hpricot'
require 'builder'
require 'tzinfo'
require 'active_support/core_ext/blank'
require 'active_support/time_with_zone'
require 'active_support/inflector'

require 'graft/model'
require 'graft/xml_attribute'
require 'graft/model/xml'
require 'graft/type'