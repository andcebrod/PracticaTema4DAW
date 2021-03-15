<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>Alta Libro</title>
</head>
<body>

	<div class="container mt-4">
		<div class="row">
			<div class="col-md-2 text-center"></div>		
			<div class="col-md-8">
				<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	                <ul class="navbar-nav mr-auto">
	                    <li class="nav-item">
							<a href="altaLibro.jsp" class="nav-link" >Alta de Libro</a>
	                    </li>
	                    <li class="nav-item">
							<a class="nav-link" href="modificarLibro.jsp" class="nav-link">Modificación de Libro</a> 
	                    </li>
						<li class="nav-item">
							<a href="autores.jsp" class="nav-link">Autores</a>
						</li>
						<li class="nav-item">
							<a href="editoriales.jsp" class="nav-link">Editoriales</a>
						</li>
						<li class="nav-item">
							<a href="pedidos.jsp" class="nav-link">Pedidos</a>
						</li>
						<li class="nav-item">
							<a href="logout.jsp" class="btn btn-danger">LOGOUT</a>	
						</li>
					</ul>
	        	</nav>
			</div>
		</div>
		<div class="row">
			<div class="col-md-2 text-center"></div>		
			<div class="col-md-8">
				<h3 class="mt-3 mb-3">Alta de Libro</h3>			
				<form method="post" action="altaLibro.jsp">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Titulo</span>
						</div>
						<input name="titulo" type="text" class="form-control"
							aria-label="Titulo" aria-describedby="basic-addon1">
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Precio</span>
						</div>
						<input name="precio" type="text" class="form-control"
							placeholder="00.00" aria-label="Precio"
							aria-describedby="basic-addon1">
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Cantidad</span>
						</div>
						<input name="cantidad" type="text" class="form-control"
							placeholder="00" aria-label="Cantidad"
							aria-describedby="basic-addon1">
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Autores</span>
						</div>
						<select name="autor"  class="form-control">
						 <%@ page import="java.sql.*"%>
						 <%
						ResultSet rs = es.studium.PracticaTema4.Conexiones.doSelect("autores", "*", "");
						while (rs.next()) {
					%>
					  		<option value="<%=rs.getString("idAutor")%>"><%=rs.getString("nombreAutor")%> <%=rs.getString("apellidosAutor")%></option>
					<%
						}
					%>
						</select>
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Editoriales</span>
						</div>
						<select name="editorial"  class="form-control">
						 <%@ page import="java.sql.*"%>
						 <%
						ResultSet rs1 = es.studium.PracticaTema4.Conexiones.doSelect("editoriales", "*", "");
						while (rs1.next()) {
					%>
					  		<option value="<%=rs1.getString("idEditorial")%>"> <%=rs1.getString("nombreEditorial")%> </option>
					<%
						}
					%>
						</select>
					</div>
					<a href="inicioAdministrador.jsp" class="btn btn-warning">Volver</a>
					<input type="submit" value="Alta" class="btn btn-success">
					
				</form>
				<%@ page import="java.sql.*"%>
				<%
					String titulo = request.getParameter("titulo");
					String precio = request.getParameter("precio");
					String cantidad = request.getParameter("cantidad");
					String autor = request.getParameter("autor");
					String editorial = request.getParameter("editorial");
					System.out.println("t "+titulo);
					System.out.println("p "+precio);
					System.out.println("c "+cantidad);
					if ((titulo != null && titulo != "") && (precio != null && precio != "") && (cantidad != null && cantidad != "")) {

						try {
							String objeto = "libros";
							String campos = "tituloLibro, precioLibro, cantidadStockLibro, idAutorFK ,idEditorialFK";
							String valores = "'" + titulo + "'," + precio + "," + cantidad + "," + autor + "," + editorial + "";
							es.studium.PracticaTema4.Conexiones.doInsert(objeto,campos,valores);
							out.print("<script>alert(\"Libro insertado\");</script>");

						} catch (Exception e) {
							out.print("<script>alert(\""+e+"\");</script>");

							System.out.print(e);
							e.printStackTrace();
						}
					} else if( titulo == "" || precio == "" || cantidad == ""){
						out.print("<script>alert(\"Es necesario informar todos lo campos\");</script>");
					}
					%>
			</div>
		</div>
	</div>
		<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	
</body>
</html>