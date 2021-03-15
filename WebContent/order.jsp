<%-- Página de órdenes de pedido --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, es.studium.PracticaTema4.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
	<title>Pedido</title>
</head>
<body>

	<div class="container">
		<div class="row mt-4">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<h1>Librería</h1>
				<hr />
				<br />
				<p>
					<strong>Elegir un libro y la cantidad:</strong>
				</p>
			</div>
			<div class="col-md-2 mt-4"><a href="logout.jsp" class="btn btn-danger">LOGOUT</a></div>
			
		</div>
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<form name="AgregarForm" action="shopping" method="POST">
					<input type="hidden" name="todo" value="add"> 
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Libro:</span>
						</div>
						<select name="idLibro">
							<%
							int tamanio = LibreriaMVC.tamano();
							System.out.println(LibreriaMVC.tamano());
								// Scriplet 1: Carga los libros en el SELECT
								for (int i = 0; i < tamanio; i++) {
									out.println("<option value='" + i + "'>");
									out.println(LibreriaMVC.getTitulo(i) + " | " + LibreriaMVC.getPrecio(i));
									out.println("</option>");
								}
							%>
						</select>
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Cantidad:</span>
						</div>
						<input type="text" name="cantidad" size="10" value="1">
					</div>
					 
					<input type="submit" value="Añadir a la cesta" class="btn btn-info">
				</form>
			</div>
		</div>

		
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
			<%
		// Scriplet 2: Chequea el contenido de la cesta
		ArrayList<ElementoPedido> cesta = (ArrayList<ElementoPedido>) session.getAttribute("carrito");
		if (cesta != null && cesta.size() > 0) {
	%>
	<p>
		<strong>Tu cesta contiene:</strong>
	</p>
	<table class="table table-light table-striped " style="text-align: left;">
		<thead class="thead-dark">
			<tr>
				<th>Título</th>
				<th>Precio</th>
				<th>Cantidad</th>
				<th>Opciones</th>
			</tr>
		</thead>
		<%
			// Scriplet 3: Muestra los libros del carrito
				for (int i = 0; i < cesta.size(); i++) {
					ElementoPedido elementoPedido = cesta.get(i);
		%>
		<tr>
			<form name="borrarForm" action="shopping" method="POST">
				<input type="hidden" name="todo" value="remove"> 
				<input	type="hidden" name="indiceElemento" value="<%=i%>">
				<td><%=elementoPedido.getTitulo()%></td>
				<td align="right"><%=elementoPedido.getPrecio()%> €</td>
				<td align="right"><%=elementoPedido.getCantidad()%></td>
				<td><input type="submit" value="Eliminar de la cesta" class="btn btn-danger"></td>
			</form>
		</tr>
		<%
			}
		%>
	</table>
	<br />
	<form name="checkoutForm" action="shopping" method="POST">
		<input type="hidden" name="todo" value="checkout"> <input
			type="submit" value="Confirmar compra" class="btn btn-success">
	</form>
	<%
		}
	%>
			</div>
		</div>
	</div>
</body>
</html>
