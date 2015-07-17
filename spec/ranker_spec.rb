require 'spec_helper'

describe Rankrb::Ranker do
	before(:each) do
    @ranker = Rankrb::Ranker.new
  end

	it 'has a nil collection by default' do
    expect(@ranker.collection).to be_nil
  end

  it 'has a nil query by default' do
    expect(@ranker.query).to be_nil
  end

  it 'returns the inverse document frequency' do
  	doc1 = Rankrb::Document.new(:body => "This is a body.")
    doc2 = Rankrb::Document.new(:body => "This is another body.")
    doc3 = Rankrb::Document.new(:body => "This is a really really long body.")
    coll = Rankrb::Collection.new(:docs => [doc1, doc2, doc3])
    @ranker.collection = coll

    term = 'another'
    idf = '%.4f' % @ranker.idf(term)

    expect(idf).to eq('%.4f' % 0.5108)
  end
end