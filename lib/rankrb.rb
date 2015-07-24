require 'rankrb/version'
require 'active_support'
require 'active_record'
require 'rankrb/query_parser'
require 'rankrb/document'
require 'rankrb/collection'


require 'rankrb/railtie' if defined? Rails
require 'rankrb/models/active_record_extension'

module Rankrb
  # Your code goes here...
end