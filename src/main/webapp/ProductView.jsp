<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	Collection<?> products = (Collection<?>) request.getAttribute("products");
	if(products == null) {
		response.sendRedirect("./product");	
		return;
	}
	
	ProductBean product = (ProductBean) request.getAttribute("product");
	
%>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.model.ProductBean"%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="ProductStyle.css" rel="stylesheet" type="text/css">
	<title>Storage DS/BF</title>
</head>

<body>
	<h2>Products</h2>
	<a href="product">List</a>
	<table border="1">
		<tr>
			<th>ID <a href="product?sort=code">Sort</a></th>
			<th>Nome <a href="product?sort=nome">Sort</a></th>
			<th>Prezzo <a href="product?sort=prezzo">asc</a>/<a href="product?sort=prezzoDec">dec</a></th>
			<th>Img </th>
			<th>Action</th>
		</tr>
		<%
			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
		%>
		<tr>
			<td><%=bean.getId()%></td>
			<td><%=bean.getNome()%></td>
			<td><%=bean.getPrezzo()%></td>
			<%
   				String stockImg = "";
   				byte[] imageData = bean.getImmagineUrl();
    			if (imageData != null) {
    		    stockImg = Base64.getEncoder().encodeToString(imageData);
    }
%>
           
			<td><img  src="data:image/jpeg;base64,<%= stockImg %>"  width=400px height=auto alt="no immagine" ></td>
			<td><a href="product?action=delete&id=<%=bean.getId()%>">Delete</a><br>
			<%//id del prodotto che vogliamo andare a cancellare %>
				<a href="product?action=read&id=<%=bean.getId()%>">Details</a><br>
				</td>
		</tr>
		<%
				}
			} else {
		%>
		<tr>
			<td colspan="6">No products available</td>
		</tr>
		<%
			}
		%>
	</table>
	
	
	<h2>Insert</h2>
	<form action="product" method="post">
		<input type="hidden" name="action" value="insert"> 
		
		<label for="nome">Nome:</label><br> 
		<input name="nome" type="text" maxlength="20" required placeholder="inserire nome"><br> 
		
		<label for="descrizione">Descrizione:</label><br>
		<textarea name="descrizione" maxlength="100" rows="3" required placeholder="inserire descrizione"></textarea><br>
		
		<label for="prezzo">Prezzo:</label><br> 
		<input name="prezzo" type="number" min="0" value="0" required><br>

		<label for="quantita">Disponibilità</label><br> 
		<input name="quantita" type="number" min="1" value="1" required><br>
		
		<label for="iva">Fascia_iva</label><br> 
		<input name="iva" type="number" min="1" value="1" required><br>
		
		<label for="dimensioni">Dimensioni</label><br> 
		<input name="dimensioni" type="text" maxlength="40" required placeholder="inserire dimensioni"><br>
		
		<label for="categoria">Categoria</label><br> 
		<input name="categoria" type="text" maxlength="40" required placeholder="inserire categoria"><br>
		
		<label for="colore">Colore</label><br> 
		<input name="colore" type="text" maxlength="40" required placeholder="inserire colore"><br>
		
		<label for="img">Image</label><br> 
		<input name="img" type="file" accept="image/png, image/jpeg"><br>

		<input type="submit" value="Add"><input type="reset" value="Reset">
	</form>
	
</body>
</html>