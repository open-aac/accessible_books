require 'json'
require 'typhoeus'
require 'nokogiri'

module AccessibleBooks
  TARHEEL_REGEX = /https?:\/\/tarheelreader.org\/.+\/.+\/.+\/(.+)\//

  def self.tarheel_id(url)
    return nil unless url
    if url.match(TARHEEL_REGEX)
      url.match(TARHEEL_REGEX)[1]
    else
      nil
    end
  end

  def self.find_json(url)
    return nil unless url
    if url.match(/dropbox\.com/) && url.match(/\?dl=0$/)
      url = url.sub(/\?dl=0$/, '?dl=1')
    end
    json = nil
    if url.match(AccessibleBooks::TARHEEL_REGEX)
      json = AccessibleBooks.tarheel_json(url)
    else
      req = Typhoeus.get(url, followlocation: true)
      json = JSON.parse(req.body) rescue nil
      if !json
        elem = Nokogiri(req.body).css("head meta[property='book:url']")[0]
        if elem && elem['content']
          req = Typhoeus.get(elem['content'])
          json = JSON.parse(req.body) rescue nil
        end
      end
    end
    if json && json['pages']
      json['image_url'] ||= json['pages'][0]['image_url']
    end
    json
  end

  def self.tarheel_json_url(id)
    return nil unless id
    "https://tarheelreader.org/book-as-json/?slug=#{CGI.escape(id)}"
  end
  
  def self.tarheel_json(url)
    return nil unless url
    id = tarheel_id(url)
    return nil unless id
    url = self.tarheel_json_url(id)
    return nil unless url
    res = Typhoeus.get(url)
    json = JSON.parse(res.body) rescue nil
    if json && json['title'] && json['pages']
      json['book_url'] = "https://tarheelreader.org#{json['link']}"
      json['attribution_url'] = "https://tarheelreader.org/photo-credits/?id=#{id}"
      json['pages'].each_with_index do |page, idx|
        page['id'] ||= idx == 0 ? 'title_page' : "page_#{idx}"
        page['image_url'] = page['url']
        page['image_url'] = "https://tarheelreader.org#{page['image_url']}" unless page['image_url'].match(/^http/)
      end
      json['image_url'] = json['pages'][1]['image_url']
    else
      json = nil
    end
    json
  end
end