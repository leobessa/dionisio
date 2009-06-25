<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<html>
<body>
<div class="flash">${message}</div>

<a href="${pageContext.request.contextPath}/products/new">new product</a>
<br/>

<table>
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
			<a href="<c:url value="/products/${product.id}"/>?_method=DELETE">delete</a>
			</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>