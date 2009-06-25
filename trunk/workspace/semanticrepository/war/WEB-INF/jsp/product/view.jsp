<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>

<html>
<body>
<div class="hproduct">
	<ul id="breadcrumbs">
		<li class="category">${product.category}</li>
	</ul>
	<h1 class="fn">${product.name}</h1>
	
	<div id="topbox">
		<div class="rightcol">
			<img src="${product.photo}" alt="Foto de ${product.name}" class="photo" />
		</div>
		<div class="leftcol">
			<div class="infomain">
				<ul>
					<li><strong>Marca: </strong><span class="brand">${product.brand}</span></li>
				</ul>
				<p class="description">${product.description}</p>
			</div>
			<div class="infoside">
				<span class="url">${product.url}</span>
				<span class="price sale">
					<span class="money">
						<strong>Preço: </strong>
						<abbr class="currency" title="BRL" lang="pt-BR">R$</abbr>
						<span class="amount">${product.price}</span>
					</span>
				</span>
				<div class="buy">
					<img src="http://img.submarino.com.br/img/btBuy.gif" alt="Comprar este produto">
				</div>
			</div>
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
	</div>
	
   
</div>
<br />
<br />
<a href="<c:url value="/products/${product.id}"/>">view</a>
|
<a href="<c:url value="/products/${product.id}"/>?_method=DELETE">delete</a>
|
<a href="<c:url value="/products"/>">list</a>


</body>
</html>