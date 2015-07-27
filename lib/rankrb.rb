require 'rankrb/version'
require 'rankrb/query_parser'
require 'rankrb/document'
require 'rankrb/collection'
require 'rankrb/tokenizer'
require 'rankrb/trie'

require 'active_support'
require 'active_record'

require 'rankrb/railtie' if defined? Rails
require 'rankrb/models/active_record_extension'

module Rankrb
  # Your code goes here...
end