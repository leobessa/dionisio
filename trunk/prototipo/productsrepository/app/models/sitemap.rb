require 'nokogiri'
require 'open-uri'

class Sitemap
  
  attr_accessor :uri
  
  def urls
    doc = Nokogiri::XML(open(uri))
    entries = []
    doc.search('urlset/url').each do |url|
      loc = url.search('loc').first.content
      changefreq = url.search('changefreq').first.content
      priority = url.search('priority').first.content
      entries << {:location => loc, :change_freq => changefreq, :priority => priority}
    end
    entries
  end
  
end