require 'rubygems'
require 'open-uri'
require 'mechanize'
require 'submarino_offer_parser.rb'

class SubmarinoCrawler

  def initialize
    super
    init
    @m = WWW::Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }
  end

  def init
    @visited = []
    @menu =[]
    @products = []
    @parser = SubmarinoOfferParser.new
  end

  def remember(link)
    @visited << link
  end


  def find_offers
    base_url = "http://www.submarino.com.br"
    sitemap = Sitemap.new
    categorias = %w{bebes
    beleza+saude
    brinquedos
    cama+mesa+banho
    cameras+digitais+filmadoras
    cds
    celular+telefonia
    departamentos
    dvds+blu-ray
    eletrodomesticos
    eletronicos+audio+video
    eletroportateis
    esporte+lazer
    ferramentas
    games
    instrumentos+musicais
    livros+importados
    livros
    notebooks+computadores
    papelaria
    perfumaria
    relogios+presentes
    sitemap
    utilidades+domesticas
    vestuario
    vinhos+bebidas}
    categorias.each do |categoria|
      sitemap.uri = "http://www.submarino.com.br/#{categoria}.xml"
      sitemap.urls.each do |url|
        yield url[:location]
      end 
    end
    @products
  end    
  
  def matches_offer(url)
    regex = /(.*\/produto\/\d*\/\d*)/
    url =~ regex
  end

  def import_offer(url, options = {:save => true})
    regex = /(.*\/produto\/\d*\/\d*)/
    url =~ regex
    puts "Loading #{$1}"
    p = @parser.fetch_offer(URI.parse($1))
    p.save if options[:save]
    p
  end

  def import_offers
    find_offers do |link|
      begin
        import_offer(link)
      rescue Exception => e  
        puts "Problems parsing #{link}"
        puts e.message  
        puts e.backtrace.inspect  
      end
    end
  end

end
