module ActiveRecordExtension
  extend ActiveSupport::Concern

  class_methods do
    def search(str)
    	"searching"
      # Run a find query that looks at the inverted index.
      # Then use Rankrb::Collection's bm25 method to rank the results.
    end
  end

  included do
  	before_save :add_to_inverted_index
  end

  def add_to_inverted_index
  end
end
# Include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtension)