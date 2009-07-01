<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" pageEncoding="UTF-8"%>

<html>
<body>
	
	<c:forEach var="error" items="${errors}">
		<li>${error.message } - ${error.category }</li>
	</c:forEach>
	<form action="<c:url value="/products"/>" method="post" accept-charset="utf-8" >
	<table>
		<tr>
			<td>Name:</td>
			<td><input type="text" name="Product.name" value="" /> (min length: 5)</td>
		</tr>
		<tr>
			<td>Store Name:</td>
			<td><input type="text" name="Product.storeName" value="" /></td>
		</tr>
		<tr>
			<td>Brand:</td>
			<td><input type="text" name="Product.brand" value="" /></td>
		</tr>
		<tr>
			<td>Category:</td>
			<td><input type="text" name="Product.category" value="" /></td>
		</tr>
		<tr>
			<td>Description:</td>
			<td><input type="text" name="Product.description" value="" /></td>
		</tr>
		<tr>
			<td>Price:</td>
			<td><input type="text" name="Product.price" value="" /></td>
		</tr>
		<tr>
			<td>Photo:</td>
			<td><input type="text" name="Product.photo" value="" /></td>
		</tr>
		<tr>
			<td>URL:</td>
			<td><input type="text" name="Product.url" value="" /></td>
		</tr>
		
		<tr>
			<td colspan="2"><input type="submit" /></td>
		</tr>
	</table>
	</form>
</body>
</html>