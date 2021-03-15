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
<title>Autores</title>
</head>
<body>
	<div class="container mt-4">
		<div class="row">
			<div class="col-md-2 text-center"></div>		
			<div class="col-md-8">
				<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
					<ul class="navbar-nav mr-auto">
						<li class="nav-item"><a href="altaLibro.jsp" class="nav-link">Alta
								de Libro</a></li>
						<li class="nav-item"><a class="nav-link"
							href="modificarLibro.jsp" class="nav-link">Modificación de
								Libro</a></li>
						<li class="nav-item"><a href="autores.jsp" class="nav-link">Autores</a>
						</li>
						<li class="nav-item"><a href="editoriales.jsp"
							class="nav-link">Editoriales</a></li>
						<li class="nav-item"><a href="pedidos.jsp" class="nav-link">Pedidos</a>
						</li>
						<li class="nav-item"><a href="logout.jsp"
							class="btn btn-danger">LOGOUT</a></li>
					</ul>
				</nav>
			</div>
		</div>
		<div class="row">
			<div class="col-md-2 text-center"></div>		
			<div class="col-8 text">

				<h3 class="mt-3 mb-3">Autores</h3>
	
				<table class="table table-light table-striped " style="text-align: left;">
					<thead class="thead-dark">
						<tr>
							<th>Nombre del Autor</th>
							<th>Apellidos del Autor</th>
						</tr>
					</thead>
					<tbody>
					<%@ page import="java.sql.*"%>
					<%
						ResultSet rs = es.studium.PracticaTema4.Conexiones.doSelect("autores", "*", " ORDER BY apellidosAutor, nombreAutor ");
						while (rs.next()) {
					%>
					<tr>
						<td><%=rs.getString("nombreAutor")%></td>
						<td><%=rs.getString("apellidosAutor")%></td>
					</tr>
					<%
						}
					%>
					</tbody>
				</table>
				<a href="inicioAdministrador.jsp"><button class="btn btn-warning">Volver</button></a>
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