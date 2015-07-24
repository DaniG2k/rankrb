#module ActiveRecordExtension
#  extend ActiveSupport::Concern

#  module ClassMethods
#    def foo
#      "foo"
#    end
#  end
#end
# Include the extension 
#ActiveRecord::Base.send(:include, ActiveRecordExtension)