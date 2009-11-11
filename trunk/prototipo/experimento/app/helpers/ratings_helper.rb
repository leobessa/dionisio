module RatingsHelper
  def on_click_unknown_radio_save(product) 
    "Element.show('status-of-product-#{product.id}-rating'); " +
    "new Ajax.Request('/products/#{product.id}/unknown', {asynchronous:true, evalScripts:true, " +
    "onComplete:function(request){ 
       Element.hide('status-of-product-#{product.id}-rating'); 
       if (request.status == 0){ 
         alert('O servidor não está respondendo. Tente novamente mais tarde.'); 
         $$('#radio-button-for-product-#{product.id} input[type=radio]').each(function(radio){ radio.checked = false })  
       } 
     }, " + 
    "onFailure:function(request){ alert('Ocorreu um erro no servidor. Tente novamente.');}, " + 
    "parameters:'rating[unknown]=' + encodeURIComponent(this.value)})"
  end
end 


