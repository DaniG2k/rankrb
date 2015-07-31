require 'spec_helper'

describe Rankrb::Document do
  before :each do
    @doc = Rankrb::Document.new
  end

  it '#body takes a document body' do
  	@doc.body = "This is a body."
    expect(@doc).not_to be nil
  end

  it '#id defaults to nil' do
    expect(@doc.id).to be(nil)
  end

  it '#id returns the document id' do
    @doc.id = 1
    expect(@doc.id).to be(1)
  end

  it '#body defaults to an empty string' do
    expect(@doc.body).to eq('')
  end

  it '#rank defaults to nil' do
    expect(@doc.rank).to be_nil
  end

  it '#length returns a document\'s body length' do
  	@doc.body = "This is a body."
    expect(@doc.length).to eq(15)
  end

  it '#include? returns true if a document includes a specific string' do
  	@doc.body = "Japan is also known as the Land of the Rising Sun."
    expect(@doc.include?("Japan")).to be true
  end

  it '#term_freq returns frequency of a string in a document body' do
    @doc.body = 'In this document here, there are some terms that repeat here.'
    expect(@doc.term_freq("here")).to eq(2)
  end

  it '#tokens returns the uniqe terms in a document' do
    @doc.body = 'In this document here, there are some terms that repeat here.'
    res = %w(in this document here there are some terms that repeat)
    expect(@doc.tokens).to eq(res)
  end
end
