require 'spec_helper'

describe Rankrb::Document do
  before :each do
    @doc = Rankrb::Document.new
  end

  it 'has a body' do
  	@doc.body = "This is a body."
    expect(@doc).not_to be nil
  end

  it 'has a default empty string as a body' do
    expect(@doc.body).to eq('')
  end

  it 'has a default nil rank' do
    expect(@doc.rank).to be_nil
  end

  it 'returns a document\'s body length' do
  	@doc.body = "This is a body."
    expect(@doc.length).to eq(15)
  end

  it 'returns true if a document includes a string' do
  	@doc.body = "Japan is also known as the Land of the Rising Sun."
    expect(@doc.include?("Japan")).to be true
  end
end
