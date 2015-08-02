module ActiveRecordExtension
  extend ActiveSupport::Concern

  class_methods do
    def search(str)
      query = Rankrb::Tokenizer.new(str).tokenize
      # Load the inverted index.
      # Run .find to search for the keywords.
      # Use Rankrb::Collection's bm25 method to rank the results.
    end

    def import
      coll = Rankrb::Collection.new
      all.each do |obj|
        # TODO:
        # Will need to import custom fields evnetually
        coll.docs << Rankrb::Document.new(:id => obj.id, :body => obj.body)
      end
      index = Rankrb::InvertedIndex.new(:collection => coll)
      index.build
      # TODO:
      # Commit db
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
