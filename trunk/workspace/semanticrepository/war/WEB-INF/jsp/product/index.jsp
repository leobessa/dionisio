<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" pageEncoding="UTF-8"%>

<html>
<head> 
	   <title>Product List</title> 
	   <link rel="stylesheet" href="http://yui.yahooapis.com/2.7.0/build/reset-fonts-grids/reset-fonts-grids.css" type="text/css">
	   <style type="text/css">
	    body
		{
			line-height: 1.6em;
		}
		
		#hor-minimalist-a
		{
			font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
			font-size: 12px;
			background: #fff;
			margin: 45px;
			width: 480px;
			border-collapse: collapse;
			text-align: left;
		}
		#hor-minimalist-a th
		{
			font-size: 14px;
			font-weight: normal;
			color: #039;
			padding: 10px 8px;
			border-bottom: 2px solid #6678b1;
		}
		#hor-minimalist-a td
		{
			color: #669;
			padding: 9px 8px 0px 8px;
		}
		#hor-minimalist-a tbody tr:hover td
		{
			color: #009;
		}
		
			   
	   </style>
</head>
<body>
	<div id="doc" class="yui-t4"> 
	   <div id="hd" role="banner"><h1>Social Store</h1></div> 
	   <div id="bd" role="main"> 
	    <div id="yui-main"> 
	    <div class="yui-b"><div role="main" class="yui-g"> 
	    <!-- YOUR DATA GOES HERE --> 
			<div class="flash">${message}</div>
			
			<a href="${pageContext.request.contextPath}/products/new">new product</a>
			<br/>
			
			<table id="hor-minimalist-a">
				<tr>
					<th>Id</th>
					<th>Name</th>
					<th>Actions</th>
				</tr>
				<c:forEach var="product" items="${productList}" >
					<tr>
						<td>${product.id}</td>
						<td>${product.name}</td>
						<td><a href="<c:url value="/products/${product.id}"/>">view</a> |
						<a href="<c:url value="/products/edit/${product.id}"/>">edit</a> |
						<a href="<c:url value="/products/${product.id}"/>?_method=DELETE">delete</a>
						</td>
					</tr>
				</c:forEach>
			</table>
			
			</div> 
	</div> 
	    </div> 
	    <div class="yui-b">
	    <!-- YOUR NAVIGATION GOES HERE -->
	    	<!-- Define the div tag where the gadget will be inserted. -->
			<div id="div-6367175247030572730" style="width:276px;border:1px solid #cccccc;"></div>
			<!-- Define the div tag where the gadget will be inserted. -->
			<div id="div-3520674405091531390" style="width:300px;border:1px solid #cccccc;"></div>
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
skin['HEADER_TEXT'] = 'Recommended Products';
skin['RECOMMENDATIONS_PER_PAGE'] = '5';
google.friendconnect.container.setParentUrl('/' /* location of rpc_relay.html and canvas.html */);
google.friendconnect.container.renderOpenSocialGadget(
 { id: 'div-3520674405091531390',
   url:'http://www.google.com/friendconnect/gadgets/recommended_pages.xml',
   site: '13284033061932101962',
   'view-params':{"docId":"recommendedPages"}
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