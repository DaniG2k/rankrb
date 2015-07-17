require 'spec_helper'

describe Rankrb::Collection do
  it 'returns the number of documents containing a given term' do
    str = 'Experts worldwide are gathering in the East Asian peninsula to architect the cities of the future'
    doc1 = Rankrb::Document.new :body => str
    doc2 = Rankrb::Document.new :body => 'Eastern Europe'
    coll = Rankrb::Collection.new(:docs => [doc1, doc2])

    expect(coll.containing_term('Asian')).to eq(1)
  end

  it 'returns the average document length' do
    doc1 = Rankrb::Document.new(:body => "This is a body.")
    doc2 = Rankrb::Document.new(:body => "This is another body.")
    doc3 = Rankrb::Document.new(:body => "This is a really really long body.")
    coll = Rankrb::Collection.new(:docs => [doc1, doc2, doc3])

    test_avg_dl = (doc1.length + doc2.length + doc3.length) / 3
    expect(coll.avg_dl).to eq(test_avg_dl)
  end

  it 'returns the total number of documents' do
  	doc1 = Rankrb::Document.new(:body => "This is a body.")
    doc2 = Rankrb::Document.new(:body => "This is another body.")
    coll = Rankrb::Collection.new(:docs => [doc1, doc2])

    expect(coll.total_docs).to eq(2)
  end
end
