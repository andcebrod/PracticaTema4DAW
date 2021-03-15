<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<title>Log Out</title>
</head>
<body>
	
	<%session.invalidate(); %>
	<div class="container mt-4">
      <div class="row">
      <div clss="col-md-2 text-center"></div>
        <div class="col-md-8 ">            
          <h3>Hasta pronto amigo!</h3>
          <a href="index.html" class="btn btn-success">Iniciar Sesión</a>
        </div>
      </div>
    </div>
</body>
</html>