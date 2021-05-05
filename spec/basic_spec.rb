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

  describe "search" do
    sample_str = %{{"books":[{"title":"Fat Cat, Rat and Bat","ID":255904,"slug":"fat-cat-rat-and-bat","link":"\/2020\/10\/14\/fat-cat-rat-and-bat\/","author":"#onthemat","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":["onset","rime","word","family","at"],"categories":["Anim"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"Fat Cat, Rat and Bat","url":"\/cache\/images\/65\/45209979965_9fff0c1dff_t.jpg","width":100,"height":62},"preview":{"text":"Fat Cat, Rat and Bat","url":"\/cache\/images\/65\/45209979965_9fff0c1dff.jpg","width":500,"height":308},"pages":6,"language":"en","bust":"201410054847"},{"title":"About The Borrowers by M. Norton Chpts. 16-20","ID":252711,"slug":"the-borrowers-chpts-16-20","link":"\/2020\/09\/09\/the-borrowers-chpts-16-20\/","author":"Chpts. 16-20    BWL","rating":{"icon":"\/themeV1\/images\/2stars_t.png","img":"\/themeV1\/images\/2stars.png","text":"2 stars"},"tags":[""],"categories":["Fict"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"About The Borrowers by M. Norton Chpts. 16-20","url":"\/uploads\/2020\/09\/37795-5f592389c407e_t.jpg","width":100,"height":85},"preview":{"text":"About The Borrowers by M. Norton Chpts. 16-20","url":"\/uploads\/2020\/09\/37795-5f592389c407e.jpg","width":475,"height":405},"pages":19,"language":"en","bust":"213103222056"},{"title":"About The Borrowers by M. Norton  Chpts. 6-10","ID":252608,"slug":"the-borrowers-chpts-6-10","link":"\/2020\/09\/09\/the-borrowers-chpts-6-10\/","author":"Chpts. 6-10  BWL","rating":{"icon":"\/themeV1\/images\/2stars_t.png","img":"\/themeV1\/images\/2stars.png","text":"2 stars"},"tags":[""],"categories":["Fict"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"About The Borrowers by M. Norton  Chpts. 6-10","url":"\/uploads\/2020\/09\/37795-5f57db507eb8f_t.jpg","width":100,"height":85},"preview":{"text":"About The Borrowers by M. Norton  Chpts. 6-10","url":"\/uploads\/2020\/09\/37795-5f57db507eb8f.jpg","width":475,"height":405},"pages":16,"language":"en","bust":"213103222137"},{"title":"Animal Parents and Babies","ID":243086,"slug":"animal-parents-and-babies","link":"\/2020\/05\/06\/animal-parents-and-babies\/","author":"Spedcial_Edventures","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":["animals","repetition","predictable","text"],"categories":["Anim"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"Animal Parents and Babies","url":"\/cache\/images\/54\/19924112054_efe283d29c_t.jpg","width":100,"height":66},"preview":{"text":"Animal Parents and Babies","url":"\/cache\/images\/54\/19924112054_efe283d29c.jpg","width":500,"height":333},"pages":22,"language":"en","bust":"200705112242"},{"title":"Baby Animals","ID":240824,"slug":"baby-animals-25","link":"\/2020\/05\/01\/baby-animals-25\/","author":"kdavisslp","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":[""],"categories":["Anim"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"Baby Animals","url":"\/cache\/images\/03\/8165506503_31105e0ece_t.jpg","width":100,"height":84},"preview":{"text":"Baby Animals","url":"\/cache\/images\/03\/8165506503_31105e0ece.jpg","width":500,"height":422},"pages":16,"language":"en","bust":"200705113037"},{"title":"Words Ending in AT","ID":241707,"slug":"words-ending-in-at","link":"\/2020\/04\/28\/words-ending-in-at\/","author":"Alex_delaNuez","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":["Word","Sort","Word","Endings","Literacy"],"categories":["Alph"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"Words Ending in AT","url":"\/cache\/images\/18\/27639299718_c01f991b2f_t.jpg","width":82,"height":99},"preview":{"text":"Words Ending in AT","url":"\/cache\/images\/18\/27639299718_c01f991b2f.jpg","width":412,"height":499},"pages":8,"language":"en","bust":"202904101930"},{"title":"Trip to the Pet Store","ID":240579,"slug":"trip-to-the-pet-store","link":"\/2020\/04\/15\/trip-to-the-pet-store\/","author":"Mrs. Enzor","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":[""],"categories":["Anim","Recr"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"Trip to the Pet Store","url":"\/cache\/images\/95\/193439595_d8761d2ee0_t.jpg","width":66,"height":100},"preview":{"text":"Trip to the Pet Store","url":"\/cache\/images\/95\/193439595_d8761d2ee0.jpg","width":332,"height":500},"pages":8,"language":"en","bust":"200405105041"},{"title":"Cat World BF","ID":239746,"slug":"cat-world-bf","link":"\/2020\/04\/14\/cat-world-bf\/","author":"kdavisslp","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":[""],"categories":["Anim"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"Cat World BF","url":"\/cache\/images\/18\/9328838218_a4050a636f_t.jpg","width":100,"height":70},"preview":{"text":"Cat World BF","url":"\/cache\/images\/18\/9328838218_a4050a636f.jpg","width":500,"height":351},"pages":11,"language":"en","bust":"201504095329"},{"title":"Walk in the Woods","ID":239448,"slug":"walk-in-the-woods","link":"\/2020\/04\/07\/walk-in-the-woods\/","author":"NKSD","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":[""],"categories":["Anim"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"Walk in the Woods","url":"\/cache\/images\/59\/23274513759_7dd6989d65_t.jpg","width":100,"height":66},"preview":{"text":"Walk in the Woods","url":"\/cache\/images\/59\/23274513759_7dd6989d65.jpg","width":500,"height":331},"pages":10,"language":"en","bust":"200704202422"},{"title":"Cats, Cats, Cats","ID":238775,"slug":"cats-cats-cats-6","link":"\/2020\/04\/07\/cats-cats-cats-6\/","author":"kdavisslp","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":[""],"categories":["Anim"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"Cats, Cats, Cats","url":"\/cache\/images\/27\/25690386427_8c2b3eaf76_t.jpg","width":100,"height":67},"preview":{"text":"Cats, Cats, Cats","url":"\/cache\/images\/27\/25690386427_8c2b3eaf76.jpg","width":500,"height":334},"pages":21,"language":"en","bust":"200804125214"},{"title":"Can You Eat That?","ID":239483,"slug":"can-you-eat-that","link":"\/2020\/04\/05\/can-you-eat-that\/","author":"Keilah Singleton","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":[""],"categories":["Food"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"Can You Eat That?","url":"\/cache\/images\/68\/7658298768_e4c2c2635e_t.jpg","width":100,"height":67},"preview":{"text":"Can You Eat That?","url":"\/cache\/images\/68\/7658298768_e4c2c2635e.jpg","width":500,"height":333},"pages":9,"language":"en","bust":"200804130021"},{"title":"I Want Another Pet","ID":237446,"slug":"i-want-another-pet","link":"\/2020\/04\/04\/i-want-another-pet\/","author":"watchdogs","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":["pets","rhyming","core","word","want"],"categories":["Anim","Recr"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"I Want Another Pet","url":"\/cache\/images\/37\/379959937_d8971ce552_t.jpg","width":100,"height":75},"preview":{"text":"I Want Another Pet","url":"\/cache\/images\/37\/379959937_d8971ce552.jpg","width":500,"height":375},"pages":15,"language":"en","bust":"200804130433"},{"title":"LCs Animals","ID":238332,"slug":"lcs-animals","link":"\/2020\/04\/03\/lcs-animals\/","author":"kdavisslp","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":[""],"categories":["Anim"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"LCs Animals","url":"\/cache\/images\/82\/3167480982_845d5976c0_t.jpg","width":100,"height":77},"preview":{"text":"LCs Animals","url":"\/cache\/images\/82\/3167480982_845d5976c0.jpg","width":500,"height":386},"pages":24,"language":"en","bust":"200804125324"},{"title":"MPs Animals","ID":238314,"slug":"mps-animals","link":"\/2020\/04\/03\/mps-animals\/","author":"kdavisslp","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":[""],"categories":["Anim"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"MPs Animals","url":"\/cache\/images\/13\/26786786413_b81b743afd_t.jpg","width":100,"height":75},"preview":{"text":"MPs Animals","url":"\/cache\/images\/13\/26786786413_b81b743afd.jpg","width":500,"height":379},"pages":13,"language":"en","bust":"200804130706"},{"title":"Alphabet","ID":238832,"slug":"alphabet-31","link":"\/2020\/03\/31\/alphabet-31\/","author":"Aierke","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":["English","Alphabet"],"categories":["Alph"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"Alphabet","url":"\/cache\/images\/41\/162108241_e60bdb9ab7_t.jpg","width":75,"height":100},"preview":{"text":"Alphabet","url":"\/cache\/images\/41\/162108241_e60bdb9ab7.jpg","width":375,"height":500},"pages":27,"language":"en","bust":"203103205003"},{"title":"My Animal Friends","ID":238685,"slug":"my-animal-friends-2","link":"\/2020\/03\/30\/my-animal-friends-2\/","author":"Tamara_N","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":[""],"categories":["Anim"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"My Animal Friends","url":"\/cache\/images\/35\/417299335_137b6260c0_t.jpg","width":100,"height":67},"preview":{"text":"My Animal Friends","url":"\/cache\/images\/35\/417299335_137b6260c0.jpg","width":499,"height":333},"pages":12,"language":"en","bust":"203103114838"},{"title":"I See Cats","ID":238652,"slug":"i-see-cats","link":"\/2020\/03\/30\/i-see-cats\/","author":"joimperry","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":[""],"categories":["Anim"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"I See Cats","url":"\/cache\/images\/88\/4615840388_5881911f4e_t.jpg","width":100,"height":75},"preview":{"text":"I See Cats","url":"\/cache\/images\/88\/4615840388_5881911f4e.jpg","width":500,"height":375},"pages":11,"language":"en","bust":"203003130558"},{"title":"What I See, See, See","ID":236918,"slug":"what-i-see-see-see","link":"\/2020\/03\/16\/what-i-see-see-see\/","author":"watchdogs","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":["Rhyming","see"],"categories":["Anim","Poet","Recr"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"What I See, See, See","url":"\/cache\/images\/36\/2046004336_12cf8425c4_t.jpg","width":100,"height":75},"preview":{"text":"What I See, See, See","url":"\/cache\/images\/36\/2046004336_12cf8425c4.jpg","width":500,"height":375},"pages":21,"language":"en","bust":"203103205519"},{"title":"Feeling Happy","ID":236858,"slug":"feeling-happy","link":"\/2020\/03\/16\/feeling-happy\/","author":"watchdogs","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":["Happy","feelings","core","vocabulary","like","this","is","pronouns"],"categories":["Recr"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"Feeling Happy","url":"\/cache\/images\/28\/3677764728_ff1ca6cd60_t.jpg","width":100,"height":75},"preview":{"text":"Feeling Happy","url":"\/cache\/images\/28\/3677764728_ff1ca6cd60.jpg","width":500,"height":378},"pages":19,"language":"en","bust":"203103205602"},{"title":"There Was an Old Lady","ID":234465,"slug":"there-was-an-old-lady-11","link":"\/2020\/02\/20\/there-was-an-old-lady-11\/","author":"DC","rating":{"icon":"\/themeV1\/images\/2stars_t.png","img":"\/themeV1\/images\/2stars.png","text":"2 stars"},"tags":[""],"categories":["Anim"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"There Was an Old Lady","url":"\/cache\/images\/27\/25690386427_8c2b3eaf76_t.jpg","width":100,"height":67},"preview":{"text":"There Was an Old Lady","url":"\/cache\/images\/27\/25690386427_8c2b3eaf76.jpg","width":500,"height":334},"pages":7,"language":"en","bust":"201304110159"},{"title":"Is a cat a living thing?","ID":234420,"slug":"is-a-cat-a-living-thing","link":"\/2020\/02\/20\/is-a-cat-a-living-thing\/","author":"BrownsClass","rating":{"icon":"\/themeV1\/images\/2stars_t.png","img":"\/themeV1\/images\/2stars.png","text":"2 stars"},"tags":["cats","living"],"categories":["Anim"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"Is a cat a living thing?","url":"\/cache\/images\/52\/560380352_5353d7b089_t.jpg","width":100,"height":67},"preview":{"text":"Is a cat a living thing?","url":"\/cache\/images\/52\/560380352_5353d7b089.jpg","width":500,"height":334},"pages":7,"language":"en","bust":"201304110225"},{"title":"Cats","ID":233535,"slug":"cats-219","link":"\/2020\/02\/12\/cats-219\/","author":"Cooper Hawks 2","rating":{"icon":"\/themeV1\/images\/2.5stars_t.png","img":"\/themeV1\/images\/2.5stars.png","text":"2.5 stars"},"tags":[""],"categories":["Anim"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"Cats","url":"\/cache\/images\/26\/118463026_03cfcbc0d4_t.jpg","width":100,"height":100},"preview":{"text":"Cats","url":"\/cache\/images\/26\/118463026_03cfcbc0d4.jpg","width":500,"height":500},"pages":8,"language":"en","bust":"201404101724"},{"title":"Post Man","ID":232937,"slug":"post-man","link":"\/2020\/02\/06\/post-man\/","author":"madison.sidery","rating":{"icon":"\/themeV1\/images\/2stars_t.png","img":"\/themeV1\/images\/2stars.png","text":"2 stars"},"tags":[""],"categories":["Fict"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"Post Man","url":"\/cache\/images\/68\/7717520268_9182b8bb70_t.jpg","width":100,"height":67},"preview":{"text":"Post Man","url":"\/cache\/images\/68\/7717520268_9182b8bb70.jpg","width":500,"height":334},"pages":6,"language":"en","bust":"201404103800"},{"title":"Kitty the Cat","ID":232831,"slug":"kitty-the-cat","link":"\/2020\/02\/05\/kitty-the-cat\/","author":"Lexie Creed","rating":{"icon":"\/themeV1\/images\/2stars_t.png","img":"\/themeV1\/images\/2stars.png","text":"2 stars"},"tags":["kitty","cat","animal"],"categories":["Anim"],"reviewed":true,"audience":"E","caution":false,"cover":{"text":"Kitty the Cat","url":"\/cache\/images\/27\/25690386427_8c2b3eaf76_t.jpg","width":100,"height":67},"preview":{"text":"Kitty the Cat","url":"\/cache\/images\/27\/25690386427_8c2b3eaf76.jpg","width":500,"height":334},"pages":7,"language":"en","bust":"201404105455"}],"queries2":103,"time":"0.097","more":1,"reviewer":false}}
    it "should process results" do
      res = OpenStruct.new(body: sample_str)
      expect(Typhoeus).to receive(:get).with("https://tarheelreader.org/find/?search=cat&category=&reviewed=R&audience=E&language=en&page=1&json=1", timeout: 2).and_return(res)
      list = AccessibleBooks.search('cat')
      expect(list).to_not eq(nil)
      expect(list.length).to eq(24)
      expect(list[0]).to eq({
        "author" => "#onthemat",
        "book_url" => "https://tarheelreader.org/2020/10/14/fat-cat-rat-and-bat/",
        "id" => "fat-cat-rat-and-bat",
        "image_attribution" => "https://tarheelreader.org/photo-credits/?id=255904",
        "image_url" => "https://tarheelreader.org/cache/images/65/45209979965_9fff0c1dff_t.jpg",
        "pages" => 6,
        "title" => "Fat Cat, Rat and Bat",        
      })
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