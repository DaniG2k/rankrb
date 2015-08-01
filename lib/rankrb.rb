# encoding: utf-8
require 'rankrb/version'
require 'rankrb/query_parser'
require 'rankrb/document'
require 'rankrb/collection'
require 'rankrb/tokenizer'
require 'rankrb/inverted_index'
require 'rankrb/spelling_suggester'
require 'pry'

require 'lingua/stemmer'
#require 'rankrb/stemmer'
#require 'rankrb/trie'


require 'active_support'
require 'active_record'

require 'rankrb/railtie' if defined? Rails
require 'rankrb/models/active_record_extension'

module Rankrb

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

  class Configuration
    attr_accessor :index, :language, :stopwords

    def initialize
      @index = 'db/index.json'
      @language = 'en'
      @stopwords = %w(a an and are as at be by for from has he in is it its of on she that the to was were will with)
    end
  end
end
