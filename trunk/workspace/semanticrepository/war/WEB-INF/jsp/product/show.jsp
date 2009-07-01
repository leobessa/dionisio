<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" pageEncoding="UTF-8"%>

<html>
<body>
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
					<div class="buy"><img src="http://img.submarino.com.br/img/btBuy.gif" alt="Comprar este produto"></div>
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
</div>

<a href="<c:url value="/products/edit/${product.id}"/>">edit</a>
|
<a href="<c:url value="/products/${product.id}"/>?_method=DELETE">delete</a>
|
<a href="<c:url value="/products"/>">list</a>


</body>
</html>