require 'spec_helper'
require 'accessible-books'

describe AccessibleBooks do
  describe "tarheel_id" do
    it "should return an id only if valid" do
      expect(AccessibleBooks.tarheel_id(nil)).to eq(nil)
      expect(AccessibleBooks.tarheel_id("bacon")).to eq(nil)
      expect(AccessibleBooks.tarheel_id("https://tarheelreader.org/2015/11/17/my-favorite-people-at-school/")).to eq('my-favorite-people-at-school')
      expect(AccessibleBooks.tarheel_id("https://tarheelreader.org/2013/02/18/the-princess-and-the-pea-2/")).to eq('the-princess-and-the-pea-2')
      expect(AccessibleBooks.tarheel_id("https://tarheelreader.org/2013/02/the-princess-and-the-pea-2/")).to eq(nil)
    end
  end

  describe "find_json" do
    it "should handle a nil value" do
      expect(AccessibleBooks.find_json(nil)).to eq(nil)
    end

    it "should recognize and retrieve a tarheel URL" do
      expect(AccessibleBooks).to receive(:tarheel_json).and_return({'book' => true})
      expect(AccessibleBooks.find_json("https://tarheelreader.org/2017/11/24/funny-people/")).to eq({
        'book' => true
      })
    end

    it "should try to download an arbitrary URL" do
      expect(Typhoeus).to receive(:get).with("https://www.example.com/books/123.json", followlocation: true).and_return(OpenStruct.new(body: {
        book: true
      }.to_json))
      expect(AccessibleBooks.find_json("https://www.example.com/books/123.json")).to eq({
        'book' => true
      })
    end

    it "should fix a dropbox download URL" do
      expect(Typhoeus).to receive(:get).with("https://www.dropbox.com/files/book.json?dl=1", followlocation: true).and_return(OpenStruct.new(body: {
        book: true,
        pages: [{image_url: 'https://www.example.com/pic.png'}]
      }.to_json))
      expect(AccessibleBooks.find_json("https://www.dropbox.com/files/book.json?dl=0")).to eq({
        'book' => true,
        'image_url' => 'https://www.example.com/pic.png',
        'pages' => [{'image_url' => 'https://www.example.com/pic.png'}]
      })
    end

    it "should find a head attribute and use it as a redirect" do
      expect(Typhoeus).to receive(:get).with("https:/www.example.com/api/v1/books/123.json").and_return(OpenStruct.new(body: {
        book: true
      }.to_json))
      expect(Typhoeus).to receive(:get).with("https://www.example.com/books/123", followlocation: true).and_return(OpenStruct.new(body: "
        <html><head>
          <meta property='book:url' content='https:/www.example.com/api/v1/books/123.json' />
        </head></html>
      "))
      expect(AccessibleBooks.find_json("https://www.example.com/books/123")).to eq({
        'book' => true
      })
    end

    it "should not error on bad response data" do
      expect(Typhoeus).to receive(:get).with("https://www.example.com/books/123.json", followlocation: true).and_return(OpenStruct.new(body: "asdfawgew"))
      expect(AccessibleBooks.find_json("https://www.example.com/books/123.json")).to eq(nil)
    end
  end

  describe "tarheel_json_url" do
    it "should return a correct value" do
      expect(AccessibleBooks.tarheel_json_url(nil)).to eq(nil)
      expect(AccessibleBooks.tarheel_json_url('abc')).to eq("https://tarheelreader.org/book-as-json/?slug=abc")
    end
  end
  
  describe "tarheel_json" do
    it "should ignore bad urls" do
      expect(AccessibleBooks.tarheel_json(nil)).to eq(nil)
      expect(AccessibleBooks.tarheel_json('asdf')).to eq(nil)
    end

    it "should parse the JSON response and return a processed result" do
      expect(Typhoeus).to receive(:get).with("https://tarheelreader.org/book-as-json/?slug=islands-4").and_return(OpenStruct.new(body: {"title":"Islands","author":"Andrewkssb","type":" ","audience":"E","reviewed":false,"language":"en","categories":["Peop"],"tags":["Island","Andrew","kssb"],"pages":[{"text":"Islands","url":"\/uploads\/2018\/06\/31964-5b198f2c5eb65_t.jpg","width":68,"height":100},{"text":"You can take a vacation on an island.","url":"\/uploads\/2018\/06\/31964-5b198f2c5eb65.jpg","width":344,"height":500},{"text":"They are surrounded by water.","url":"\/uploads\/2018\/06\/31964-5b198f2ca5cb8.jpg","width":500,"height":333},{"text":"Islands are beautiful!","url":"\/uploads\/2018\/06\/31964-5b198f2c66bed.jpg","width":275,"height":183}],"status":"publish","ID":200845,"author_id":"31964","rating_count":0,"rating_value":0,"rating_total":0,"modified":"2018-06-07 16:03:50","created":"2018-06-07 16:03:03","slug":"islands-4","link":"\/2018\/06\/07\/islands-4\/","bust":"180706160350"}.to_json))
      expect(AccessibleBooks.tarheel_json("https://tarheelreader.org/2018/06/07/islands-4/")).to eq({
        "title" => "Islands",
        "attribution_url" => "https://tarheelreader.org/photo-credits/?id=islands-4",
        "author" => "Andrewkssb",
        "book_url" => "https://tarheelreader.org/2018/06/07/islands-4/",
        "image_url" => "https://tarheelreader.org/uploads/2018/06/31964-5b198f2c5eb65.jpg",
        "type" => " ",
        "audience" => "E",
        "reviewed" => false,
        "language" => "en",
        "categories" => ["Peop"],
        "tags" => ["Island","Andrew","kssb"],
        "pages" => [
            {"text" => "Islands","url" => "\/uploads\/2018\/06\/31964-5b198f2c5eb65_t.jpg","width" => 68,"height" => 100, "id" => "title_page", "image_url" => "https://tarheelreader.org/uploads/2018/06/31964-5b198f2c5eb65_t.jpg"},
            {"text" => "You can take a vacation on an island.","url" => "\/uploads\/2018\/06\/31964-5b198f2c5eb65.jpg","width" => 344,"height" => 500, "id" => "page_1", "image_url" => "https://tarheelreader.org/uploads/2018/06/31964-5b198f2c5eb65.jpg"},
            {"text" => "They are surrounded by water.","url" => "\/uploads\/2018\/06\/31964-5b198f2ca5cb8.jpg","width" => 500,"height" => 333, "id" => "page_2", "image_url" => "https://tarheelreader.org/uploads/2018/06/31964-5b198f2ca5cb8.jpg"},
            {"text" => "Islands are beautiful!","url" => "\/uploads\/2018\/06\/31964-5b198f2c66bed.jpg","width" => 275,"height" => 183, "id" => "page_3", "image_url" => "https://tarheelreader.org/uploads/2018/06/31964-5b198f2c66bed.jpg"}
        ],
        "status" => "publish",
        "ID" => 200845,
        "author_id" => "31964",
        "rating_count" => 0,
        "rating_value" => 0,
        "rating_total" => 0,
        "modified" => "2018-06-07 16:03:50",
        "created" => "2018-06-07 16:03:03",
        "slug" => "islands-4",
        "link" => "\/2018\/06\/07\/islands-4\/",
        "bust" => "180706160350"
      })
    end

    it "should handle bad API responses" do
      expect(Typhoeus).to receive(:get).with("https://tarheelreader.org/book-as-json/?slug=islands-4").and_return(OpenStruct.new(body: {
        error: 'error'
      }.to_json))
      expect(AccessibleBooks.tarheel_json("https://tarheelreader.org/2018/06/07/islands-4/")).to eq(nil)
    end
  end
end

#   def self.tarheel_json(url)
#     id = url.match(Book::TARHEEL_REGEX)[1]
#     url = self.tarheel_json_url(id)
#     res = Typhoeus.get(url)
#     json = JSON.parse(res.body) rescue nil
#     if json && json['title'] && json['pages']
#       json['book_url'] = "https://tarheelreader.org#{json['link']}"
#       json['attribution_url'] = "https://tarheelreader.org/photo-credits/?id=#{id}"
#       json['pages'].each_with_index do |page, idx|
#         page['id'] ||= idx == 0 ? 'title_page' : "page_#{idx}"
#         page['image_url'] = page['url']
#         page['image_url'] = "https://tarheelreader.org#{page['image_url']}" unless page['image_url'].match(/^http/)
#       end
#     end
#     json['image_url'] = json['pages'][1]['image_url']
#     json
#   end
# end