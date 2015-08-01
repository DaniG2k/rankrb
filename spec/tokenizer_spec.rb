require 'spec_helper'

describe Rankrb::Tokenizer do
  it 'tokenizes a string' do
    str = "This is a body."
    tokenizer = Rankrb::Tokenizer.new(str)
    expect(tokenizer.tokenize).to eq(%w(this is a body))
  end

  it 'tokenizes a Japanese string' do
    str = "これは、文書体です。"
    tokenizer = Rankrb::Tokenizer.new(str)
    expect(tokenizer.tokenize).to eq(["これは","文書体です"])
  end

  it 'tokenizes a Korean string' do
    str = "이것은 문서 체입니다."
    tokenizer = Rankrb::Tokenizer.new(str)
    expect(tokenizer.tokenize).to eq(['이것은', '문서', '체입니다'])
  end

  it 'tokenizes words with apostophes properly' do
    str = "O'Neill aren't"
    expect(Rankrb::Tokenizer.new(str).tokenize).to eq(%w(oneill arent))
  end
end