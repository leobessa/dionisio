<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" pageEncoding="UTF-8"%>

<html>
<head> 
	   <title>${product.name}</title> 
	   <link rel="stylesheet" href="http://yui.yahooapis.com/2.7.0/build/reset-fonts-grids/reset-fonts-grids.css" type="text/css"> 
</head>
<body> 
	<div id="doc" class="yui-t4"> 
	   <div id="hd" role="banner"><h1>Social Store</h1></div> 
	   <div id="bd" role="main"> 
	    <div id="yui-main"> 
	    <div class="yui-b"><div role="main" class="yui-g"> 
	    <!-- YOUR DATA GOES HERE --> 
	    
		    <div class="hproduct">
				<ul id="breadcrumbs">
					<li class="lister"><a href="${product.hostDomain}">${product.storeName}</a></li>
					<li class="category">${product.category}</li>
				</ul>
				
				<div class="picside">
						<img src="${product.photo}" alt="Foto de ${product.name}" class="photo" />
				</div>
					
				<div class="infoside">
					<h1 class="fn">${product.name}</h1>
					<div class="identifier">
						<span class="type">ID</span>:
						<span class="value">${product.id}</span>
					</div>
					
					<div class="details">
							<p class="description">${product.description}</p>
							<div class="clear"></div>
							<span class="price sale">
								<span class="money">
									<strong>Preço: </strong>
									<abbr class="currency" title="BRL" lang="pt-BR">R$</abbr>
									<span class="amount">${product.price}</span>
								</span>
							</span>
							<div class="purchase">
								<div class="buy"><a href="${product.url}" ><img src="http://img.submarino.com.br/img/btBuy.gif" alt="Comprar este produto"></a></div>
							</div>
					</div>
					
					<div class="infomain">
							<ul>
								<li><strong>Marca: </strong><span class="brand">${product.brand}</span></li>
							</ul>
							<p class="description">${product.description}</p>
					</div>
					<div class="infoside">
							<span class="url">${product.url}</span>
					</div>
					<div class="clear"></div>
			
				</div>
				
				
				<!-- Define the div tag where the gadget will be inserted. -->
				<div id="div-7202500645450960587" style="width:100%;border:1px solid #cccccc;"></div>
				|
				<a href="<c:url value="/products/edit/${product.id}"/>">edit</a>
				|
				<a href="<c:url value="/products/${product.id}"/>?_method=DELETE">delete</a>
				|
				<a href="<c:url value="/products"/>">list</a>
			</div>
	    
	    </div> 
	</div> 
	    </div> 
	    <div class="yui-b">
	    <!-- YOUR NAVIGATION GOES HERE -->
	    <!-- Define the div tag where the gadget will be inserted. -->
		<div id="div-6367175247030572730" style="width:276px;border:1px solid #cccccc;"></div>
	    </div> 
	     
	    </div> 
	   <div id="ft" role="contentinfo"><p>Developer Version</p></div> 
	</div> 
	</body> 
</html>

<!-- Include the Google Friend Connect javascript library. -->
<script type="text/javascript" src="http://www.google.com/friendconnect/script/friendconnect.js"></script>

<!-- Render the gadget into a div. -->
<script type="text/javascript">
var skin = {};
skin['HEIGHT'] = '73';
skin['BORDER_COLOR'] = '#cccccc';
skin['ENDCAP_BG_COLOR'] = '#e0ecff';
skin['ENDCAP_TEXT_COLOR'] = '#333333';
skin['BUTTON_STYLE'] = 'modular';
skin['BUTTON_TEXT'] = 'Recommend it!';
skin['BUTTON_ICON'] = 'default';
skin['BUTTON_MODULE_PROMO_TEXT'] = 'Did you like this product?';
google.friendconnect.container.setParentUrl('/' /* location of rpc_relay.html and canvas.html */);
google.friendconnect.container.renderOpenSocialGadget(
 { id: 'div-7202500645450960587',
   url:'http://www.google.com/friendconnect/gadgets/recommended_pages.xml',
   height: 73,
   site: '13284033061932101962',
   'view-params':{"pageUrl":location.href,"pageTitle":(document.title ? document.title : location.href),"docId":"recommendedPages"}
 },
  skin);
</script>

<!-- Render the gadget into a div. -->
<script type="text/javascript">
var skin = {};
skin['BORDER_COLOR'] = '#cccccc';
skin['ENDCAP_BG_COLOR'] = '#e0ecff';
skin['ENDCAP_TEXT_COLOR'] = '#333333';
skin['ENDCAP_LINK_COLOR'] = '#0000cc';
skin['ALTERNATE_BG_COLOR'] = '#ffffff';
skin['CONTENT_BG_COLOR'] = '#ffffff';
skin['CONTENT_LINK_COLOR'] = '#0000cc';
skin['CONTENT_TEXT_COLOR'] = '#333333';
skin['CONTENT_SECONDARY_LINK_COLOR'] = '#7777cc';
skin['CONTENT_SECONDARY_TEXT_COLOR'] = '#666666';
skin['CONTENT_HEADLINE_COLOR'] = '#333333';
skin['NUMBER_ROWS'] = '5';
google.friendconnect.container.setParentUrl('/' /* location of rpc_relay.html and canvas.html */);
google.friendconnect.container.renderMembersGadget(
 { id: 'div-6367175247030572730',
   site: '13284033061932101962' },
  skin);
</script>
