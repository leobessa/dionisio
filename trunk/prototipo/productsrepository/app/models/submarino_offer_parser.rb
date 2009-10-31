require 'nokogiri'

class SubmarinoOfferParser
  
  def initialize
    @business = Business.find_by_name("Submarino")
    if @business.nil?
      @business = Business.create(:name => "Submarino", :url => "http://www.submarino.com.br")
    end
  end

  def fetch_offer(uri)
    parser_offer(Net::HTTP.get(uri), uri.path)
  end
  
  def parser_offer(s, uri_path, popularity=-20)
    doc = Nokogiri::HTML(s)
    offer = Offer.new
    
    name = doc.xpath(to(:name)).text.strip
    brand = doc.xpath(to(:brand)).text.strip
    category = Category.find_or_create_by_name(doc.xpath(to(:category)).text)
    offer.img_src = doc.xpath(to(:baseImg)+"/@src").text.strip
    offer.img_alt = doc.xpath(to(:baseImg)+"/@alt").text
    
    product = Product.find_by_name(name)
    
    if product.nil?
      product = Product.create(:name => name, :brand => brand, :category =>  category, :photo => offer.img_src, :popularity => popularity)
    end
    
    product.photo = offer.img_src unless product.photo 

    offer.product = product
    
    offer.business = @business
    offer.path = uri_path
    
    begin
      is_not_available = doc.xpath(to(:availability)).text.include? "Não disponível"
    

      unless is_not_available
        price_info = doc.xpath(to(:list_price)).text.split()
        offer.currency  = price_info[0]
        offer.list_price = price_info[1] && price_info[1].gsub(/[\.,]/,'')
      end
        
    end
    
    # offer.store_code = doc.xpath(to(:store_code)).text.sub(/Cod. do Produto:/, '').strip.to_i
    
    offer

    end

   private
   def to(target)
     root_path = "/html/body/div[@id='page']/div[@id='content']/div[@id='area1']/div[@id='area1A']/div[@id='area1B']/div[@id='area1C']/div[@id='area13']/div[@id='area132']"
     paths = Hash.new
     paths[:list_price] = "//ul[@class='listPriceInfo' and position()=1]/li/strong[@class='for']/span"
     paths[:name] = "#{root_path}/div[@id='area134']/div[@class='boxProductName' and position()=1]/h1/text()"
     #paths[:store_code] = "#{root_path}/div[@id='area134']/div[@class='boxProductName' and position()=1]/h1/small[@id='small']/text()"
     paths[:brand] = "#{root_path}/div[@id='area134']/div[@class='boxProductName' and position()=1]/ul[@class='brands' and position()=1]/li/a"
     paths[:baseImg] = "#{root_path}/div[@id='area133']/div[@class='boxProductPics']/div[@class='productPicFull' and position()=1]/a[@class='lightwindow']/img[@id='baseImg']"
     paths[:category] = "//html/body/div[@id='page']/div[@id='content']/div[@id='area1']/div[@id='area1A']/div[@id='area1B']/div[@id='area1C']/div[@id='area13']/div[@id='area131']/div[@class='breadcrumbBox' and position()=2]/ul[@class='breadcrumb']/li[1]/a"
     paths[:availability] = "#{root_path}/div[@id='area134']/div[3]/div[@class='unavailableProduct']/div[@class='roundCornerTL']/div[@class='roundCornerTR']/div[@class='roundCornerBL']/div[@class='roundCornerBR']/div[@id='_form']/h3[@class='title18']"
     
     paths[target]
   end
end
