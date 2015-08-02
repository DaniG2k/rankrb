module ActiveRecordExtension
  extend ActiveSupport::Concern

  class_methods do
    def search(str)
      "searching"
      # Load the inverted index.
      # Run .find to search for the keywords.
      # Use Rankrb::Collection's bm25 method to rank the results.
    end

    def import
      # TODO:
      # Will need to import custom fields evnetually
      binding.pry
      coll = Rankrb::Collection.new
      all.each do |obj|
        coll.docs << Rankrb::Document.new(:id => obj.id, :body => obj.body)
      end
      index = Rankrb::InvertedIndex.new(:collection => coll)
    end
  end

  included do
    after_save :add_to_inverted_index
  end

  def add_to_inverted_index
  end
end
# Include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtension)
