require 'spec_helper'

describe Rankrb::Collection do
  it '#containing_term returns the number of documents containing a given term' do
    str = 'Experts worldwide are gathering in the East Asian peninsula to architect the cities of the future'
    doc1 = Rankrb::Document.new :body => str
    doc2 = Rankrb::Document.new :body => 'Eastern Europe'
    coll = Rankrb::Collection.new(:docs => [doc1, doc2])

    expect(coll.containing_term('Asian')).to eq(1)
  end

  it '#<< adds a given document to a collection' do
    doc1 = Rankrb::Document.new(:body => "This is a body.", :id => 1)
    coll = Rankrb::Collection.new
    coll.docs << doc1
    expect(coll.docs[0]).to eq(doc1)
  end

  it '#remove_doc removes a given document from a collection' do
    doc1 = Rankrb::Document.new(:body => "This is a body.", :id => 1)
    coll = Rankrb::Collection.new(:docs => [doc1])
    coll.remove_doc(doc1)
    expect(coll.docs).to eq([])
  end

  it '#avg_dl returns the average document length' do
    doc1 = Rankrb::Document.new(:body => "This is a body.", id: 1)
    doc2 = Rankrb::Document.new(:body => "This is another body.", id: 2)
    doc3 = Rankrb::Document.new(:body => "This is a really really long body.", id: 3)
    coll = Rankrb::Collection.new

    [doc1, doc2, doc3].each do |doc|
      coll.docs << doc
    end

    test_avg_dl = (doc1.length + doc2.length + doc3.length) / 3
    expect(coll.avg_dl).to eq(test_avg_dl)
  end

  it '#total_docs returns the total number of documents' do
  	doc1 = Rankrb::Document.new(:body => "This is a body.")
    doc2 = Rankrb::Document.new(:body => "This is another body.")
    coll = Rankrb::Collection.new(:docs => [doc1, doc2])

    expect(coll.total_docs).to eq(2)
  end

  it '#idf returns the inverse document frequency' do
    doc1 = Rankrb::Document.new(:body => "This is a body.")
    doc2 = Rankrb::Document.new(:body => "This is another body.")
    doc3 = Rankrb::Document.new(:body => "This is a really really long body.")
    coll = Rankrb::Collection.new

    [doc1, doc2, doc3].each do |doc|
      coll.docs << doc
    end
    term = 'another'

    expect(coll.idf(term)).to be_within(0.0001).of(0.5108)
  end

  it '#bm25 calculates the score of docs in a collection using the Okapi BM25+ algorithm' do
    doc1 = Rankrb::Document.new(:body => "To reduce the estimated construction cost of ¥252 billion and ease growing criticism, Prime Minister Shinzo Abe said Friday that the new National Stadium to be built for the 2020 Tokyo Olympics will be redesigned from scratch. This means Japan will renege on its promise to use the venue for the 2019 Rugby World Cup because the new stadium won’t be built in time, Abe said.")
    doc2 = Rankrb::Document.new(:body => "It's never too late to learn, at least for this Chinese great grandmother. Zhao Shunjin, from Hangzhou in eastern China, has just been taught how to write her own name at the ripe age of 100. Her son, Luo Rongsheng, 70, told CNN that Zhao announced at a family dinner in June that she would like to learn how to read and write. She has now mastered about 100 Chinese characters after taking an intensive 10-day literacy program held by her neighborhood committee, according to Luo.")
    doc3 = Rankrb::Document.new(:body => "The Japanese government has decided to scrap its controversial plans for the stadium for the 2020 Tokyo Olympics and Paralympics. Prime Minister Shinzo Abe said his government would \"start over from zero\" and find a new design. The original design, by British architect Zaha Hadid, had come under criticism as estimated building costs rose to $2bn (£1.3bn) Mr Abe says the new stadium will still be completed in time for the games. However, the delay means that the stadium will no longer be ready in time for the 2019 Rugby World Cup, which Japan is also hosting. \"I have been listening to the voices of the people and the athletes for about a month now, thinking about the possibility of a review,\" Mr Abe said.")
    coll = Rankrb::Collection.new(:docs => [doc1, doc2, doc3], :query => 'Shinzo Abe said')
    
    sorted = coll.bm25
    first, second, third = sorted.shift, sorted.shift, sorted.shift
    
    expect(first.rank).to be_within(0.001).of(2.022)
    expect(second.rank).to be_within(0.001).of(2.297)
    expect(third.rank).to be_within(0.001).of(3.00)
  end
end
