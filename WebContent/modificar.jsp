
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
	try {
		String idLibro = request.getParameter("idLibro");
		String where = "WHERE idLibro="+idLibro+" ;";
		ResultSet resultSet = es.studium.PracticaTema4.Conexiones.doSelect("libros", "*", where);
		while (resultSet.next()) {
%>
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
<title>Modificando</title>
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
			<div class="col-md-8">
				<h2>Administrador</h2>
				<form method="post" action="modificarFinal.jsp">
					<%
						String titulo = resultSet.getString("tituloLibro");
						String precio = resultSet.getString("precioLibro");
						String cantidad = resultSet.getString("cantidadStockLibro");
						String autor = resultSet.getString("idAutorFK");
						String editorial = resultSet.getString("idEditorialFK");
						System.out.println("t "+titulo);
						System.out.println("p "+precio);
						System.out.println("c "+cantidad);
						System.out.println("a "+autor);
						System.out.println("e "+editorial);
						
					%>
					<div class="input-group mb-3 d-none">
						<input name="idLibro" type="text" class="form-control" aria-label="Titulo" aria-describedby="basic-addon1" value="<%=idLibro%>">
					</div>
					
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1" >Titulo</span>
						</div>
						<input name="titulo" type="text" class="form-control" aria-label="Titulo" aria-describedby="basic-addon1" value="<%=titulo%>">
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Precio</span>
						</div>
						<input name="precio" type="text" class="form-control"
							placeholder="00.00" aria-label="Precio"
							aria-describedby="basic-addon1" value="<%=precio%>">
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="basic-addon1">Cantidad</span>
						</div>
						<input name="cantidad" type="text" class="form-control"
							placeholder="00" aria-label="Cantidad"
							aria-describedby="basic-addon1" value="<%=cantidad%>">
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
							if(autor.contains(rs.getString("idAutor"))){
								out.print("<option value=\""+rs.getString("idAutor")+"\" selected=\"selected\">"+rs.getString("nombreAutor")+" "+rs.getString("apellidosAutor")+"</option>");
							} else {
								out.print("<option value=\""+rs.getString("idAutor")+"\">"+rs.getString("nombreAutor")+" "+rs.getString("apellidosAutor")+"</option>");
							
							}
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
							if(editorial.contains(rs1.getString("idEditorial"))){
								out.print("<option value=\""+rs1.getString("idEditorial")+"\" selected=\"selected\">"+rs1.getString("nombreEditorial")+"</option>");
							} else {
								out.print("<option value=\""+rs1.getString("idEditorial")+"\" >"+rs1.getString("nombreEditorial")+"</option>");
							
							}
						}
					%>
						</select>
					</div>
				<a href="inicioAdministrador.jsp" class="btn btn-warning">Volver</a>
					<button class="btn btn-success" type="submit" >Modificar libro</button>
				</form>
				<%
						}
					} catch (Exception e) {
						out.print("<script>alert(\""+e+"\");</script>");
					}
				%>
			</div>
		</div>
	</div>
</body>
</html>