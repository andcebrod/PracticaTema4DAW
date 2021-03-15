<%-- Página de confirmación del pedido --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, es.studium.PracticaTema4.*" %>

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
<title>Confirmación</title>
</head>
<body>

    <div class="container">
		<div class="row">
	    	<div class="col-md-2"></div>
	    	<div class="col-md-8">
				<h1>Librería MVC: Confirmación</h1>
			    <hr />
			    <br />
			    <p>
			        <strong>Has comprado los siguientes libros:</strong>
			    </p>
	    	</div>
    	</div>
    	<div class="row">
	    	<div class="col-md-2"></div>
	    	<div class="col-md-8">
				<table class="table table-light table-striped " style="text-align: left;">
					<thead class="thead-dark">
				        <tr>
				            <th>Título</th>
				            <th>Precio</th>
				            <th>Cantidad</th>
				        </tr>
			        </thead>
			        <tbody>
				
						<%@ page import="java.sql.*"%>
						<%@ page import="java.time.LocalDateTime"%>
						<%@ page import="javax.servlet.http.HttpSession "%>
				        
				        <%
						String idUsuario = session.getAttribute("idUsuario").toString();
						LocalDateTime fechaPedido = LocalDateTime.now();
						String valores = "'"+fechaPedido+"', "+idUsuario;
						String idPedido;
								
				        es.studium.PracticaTema4.Conexiones.doInsert("pedidos"," fechaPedido, idUsuarioFK ",valores);
						ResultSet rsetPedido = es.studium.PracticaTema4.Conexiones.doSelect("pedidos","*"," ORDER BY idPedido desc ");
						rsetPedido.next();
						idPedido = rsetPedido.getString("idPedido");
				        
				            // Muestra los elementos del carrito
				            ArrayList<ElementoPedido> cesta = (ArrayList<ElementoPedido>) session.getAttribute("carrito");
				            for (ElementoPedido item : cesta) {
				            	
				            	String valoresIncluyen = idPedido+", "+item.getIdLibro()+", "+item.getCantidad();
				            	System.out.println(valoresIncluyen);
				            	es.studium.PracticaTema4.Conexiones.doInsert("incluyen", "idPedidoFK, idLibroFK, cantidadLibro",valoresIncluyen );
				        %>
				        <tr>
				            <td><%=item.getTitulo()%></td>
				            <td align="right"><%=item.getPrecio()%> €</td>
				            <td align="right"><%=item.getCantidad()%></td>
				        </tr>
				        <%
				            }
				            session.invalidate();
				        %>
				        <tr>
				            <td align="right" colspan="2"><strong>Total</strong></td>
				            <td align="right"><strong><%=request.getAttribute("precioTotal")%></strong></td>
				        </tr>
		        	</tbody>
		    </table>
    		<br />
    		<a href="shopping">Pulsa aquí para realizar otro pedido</a>
	    	</div>
    	</div>
    	
    </div>

</body>
</html>