require 'spec_helper'

describe Rankrb::Tokenizer do
  before :each do
    @tokenizer = Rankrb::Tokenizer.new 
  end

  it 'tokenizes a string' do
    @tokenizer.str = "This is a body."
    expect(@tokenizer.tokenize).to eq(%w(this is a body))
  end

  it 'tokenizes a Japanese string' do
    @tokenizer.str = "これは、文書体です。"
    expect(@tokenizer.tokenize).to eq(["これは","文書体です"])
  end

  it 'tokenizes a Korean string' do
    @tokenizer.str = "이것은 문서 체입니다."
    expect(@tokenizer.tokenize).to eq(['이것은', '문서', '체입니다'])
  end

  it 'tokenizes words with apostophes properly' do
    @tokenizer.str = "O'Neill aren't"
    expect(@tokenizer.tokenize).to eq(%w(oneill arent))
  end

  it '#remove_stopwords! removes unwanted words' do
    @tokenizer.str = 'To be or not to be, that is the question.'
    @tokenizer.tokenize
    expect(@tokenizer.remove_stopwords!).to eq(%w(or not question))
  end
end