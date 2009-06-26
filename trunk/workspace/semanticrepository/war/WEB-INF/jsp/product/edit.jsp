<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" pageEncoding="UTF-8"%>

<html>
<body>
	
	<c:forEach var="error" items="${errors}">
		<li>${error.message } - ${error.category }</li>
	</c:forEach>
	<form action="<c:url value="/products/${product.id}"/>" method="PUT"  accept-charset="utf-8" >
	<input type="hidden" name="_method" value="PUT">
	<table>
		<tr>
			<td>Name:</td>
			<td><input type="text" name="product.name" value="${product.name}" /> (min length: 5)</td>
		</tr>
		<tr>
			<td>Brand:</td>
			<td><input type="text" name="Product.brand" value="${product.brand}" /></td>
		</tr>
		<tr>
			<td>Category:</td>
			<td><input type="text" name="Product.category" value="${product.category}" /></td>
		</tr>
		<tr>
			<td>Description:</td>
			<td><input type="text" name="Product.description" value="${product.description}" /></td>
		</tr>
		<tr>
			<td>Price:</td>
			<td><input type="text" name="Product.price" value="${product.price}" /></td>
		</tr>
		<tr>
			<td>Photo:</td>
			<td><input type="text" name="Product.photo" value="${product.photo}" /></td>
		</tr>
		<tr>
			<td>URL:</td>
			<td><input type="text" name="Product.url" value="${product.url}" /></td>
		</tr>
		
		<tr>
			<td colspan="2"><input type="submit" /></td>
		</tr>
	</table>
	</form>
</body>
</html>