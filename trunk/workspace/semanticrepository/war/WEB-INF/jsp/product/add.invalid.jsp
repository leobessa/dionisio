<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>

<html>
<c:forEach var="error" items="${errors }">
${error.category } ${error.message }
</c:forEach>
</html>