require 'spec_helper'

describe Rankrb::InvertedIndex do
  before :each do
    @iidx = Rankrb::InvertedIndex.new
  end

  it '#build defaults to an empty hash' do
    expect(@iidx.build).to be_kind_of(Hash)
  end

  it '#build makes the inverted index' do
    d1 = Rankrb::Document.new :body => "new home sales top forecasts", :id => 1
    d2 = Rankrb::Document.new :body => "home sales rise in july", :id => 2
    d3 = Rankrb::Document.new :body => "increase in home sales in july", :id => 3
    d4 = Rankrb::Document.new :body => "july new home sales rise", :id => 4

    @iidx.docs = [d1, d2, d3, d4]
    result = {
      "new"=>[1, 4],
      "home"=>[1, 2, 3, 4],
      "sale"=>[1, 2, 3, 4],
      "top"=>[1],
      "forecast"=>[1],
      "rise"=>[2, 4],
      "in"=>[2, 3],
      "juli"=>[2, 3, 4],
      "increas"=>[3]
    }
    expect(@iidx.build).to eq(result)
  end

  it "#build sorts the tokens's doc ids" do
    d3 = Rankrb::Document.new :body => "increase in home sales in july", :id => 3
    d1 = Rankrb::Document.new :body => "new home sales top forecasts", :id => 1
    @iidx.docs = [d3, d1]
    
    result = {
      "increase"=>[3],
      "in"=>[3],
      "home"=>[3, 1],
      "sales"=>[3, 1],
      "july"=>[3],
      "new"=>[1],
      "top"=>[1],
      "forecasts"=>[1]
    }
    expect(@iidx.build).not_to eq(result)
  end

  it '#query returns the document ids for a word' do
    d1 = Rankrb::Document.new :id => 1, :body => "breakthrough drug for schizophrenia"
    d2 = Rankrb::Document.new :id => 2, :body => "new schizophrenia drug"
    @iidx.docs = [d1, d2]
    @iidx.build
    expect(@iidx.query('breakthrough')).to eq([1])
  end

  it '#query_and performs a conjunctive query' do
    d1 = Rankrb::Document.new :id => 1, :body => "breakthrough drug for schizophrenia"
    d2 = Rankrb::Document.new :id => 2, :body => "new schizophrenia drug"
    d3 = Rankrb::Document.new :id => 3, :body => "new approach for treatment of schizophrenia"
    d4 = Rankrb::Document.new :id => 4, :body => "new hopes for schizophrenia patients"
    @iidx.docs = [d1, d2, d3, d4]
    @iidx.build
    expect(@iidx.query_and(['schizophrenia', 'drug'])).to eq([1, 2])
  end

  it '#query_or performs a disjunctive query' do
    d1 = Rankrb::Document.new :id => 1, :body => "breakthrough drug for schizophrenia"
    d2 = Rankrb::Document.new :id => 2, :body => "new schizophrenia drug"
    d3 = Rankrb::Document.new :id => 3, :body => "new approach for treatment of schizophrenia"
    d4 = Rankrb::Document.new :id => 4, :body => "new hopes for schizophrenia patients"
    @iidx.docs = [d1, d2, d3, d4]
    @iidx.build
    expect(@iidx.query_or(['schizophrenia', 'drug'])).to eq([*1..4])
  end

  it '#remove_doc removes a given document from the inverted index' do
    d1 = Rankrb::Document.new :id => 1, :body => "breakthrough drug for schizophrenia"
    d2 = Rankrb::Document.new :id => 2, :body => "new schizophrenia drug"
    d3 = Rankrb::Document.new :id => 3, :body => "new approach for treatment of schizophrenia"
    d4 = Rankrb::Document.new :id => 4, :body => "new hopes for schizophrenia patients"
    @iidx.docs = [d1, d2, d3, d4]
    @iidx.build
    @iidx.remove_doc(d1)
    expect(@iidx.iidx).not_to have_key('breakthrough')
    @iidx.iidx.each {|k, v| expect(v).not_to include(1)}
  end
end