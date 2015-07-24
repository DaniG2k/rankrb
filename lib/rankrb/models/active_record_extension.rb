module ActiveRecordExtension
  extend ActiveSupport::Concern

  module ClassMethods
    def search(str)
      # Run a find query that looks at the inverted index.
      # Then use Rankrb::Collection's bm25 method to rank the results.
    end
  end
end
# Include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtension)