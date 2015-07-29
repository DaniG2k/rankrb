# encoding: utf-8
require 'rankrb/version'
require 'rankrb/query_parser'
require 'rankrb/document'
require 'rankrb/collection'
require 'rankrb/tokenizer'
require 'rankrb/inverted_index'

require 'lingua/stemmer'
#require 'rankrb/stemmer'
#require 'rankrb/trie'


require 'active_support'
require 'active_record'

require 'rankrb/railtie' if defined? Rails
require 'rankrb/models/active_record_extension'

module Rankrb
  class Configuration
    attr_accessor :index
  end
  
  def self.❨╯°□°❩╯︵┻━┻
    'Calm down yo!'
  end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @config ||= Configuration.new
  end

  def self.configure
    # Can configure as such:
    # Obj.configure do |conf|
    #   conf.some_key = 'abc123'
    # end
    yield(configuration) if block_given?
  end
end