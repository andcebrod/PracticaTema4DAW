package es.studium.PracticaTema4;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
@WebServlet(
		name = "LoginServlet",
		urlPatterns = {"/login"})

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// Pool de conexiones a la base de datos
	private DataSource pool;
	public LoginServlet() {
		super();
	}
	public void init(ServletConfig config) throws ServletException {
		try {
			// Crea un contexto para poder luego buscar el recurso DataSource
			InitialContext ctx = new InitialContext();
			// Busca el recurso DataSource en el contexto
			pool = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql_tiendalibros");
			if(pool == null) {
				throw new ServletException("DataSource desconocida 'mysql_tiendalibros' ");
			}
		}
		catch(NamingException ex){}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		Connection conn = null;
		Statement stmt = null;
		try {
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head>");
			out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\">\r\n");
			out.println("<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css\" "
					+ "integrity=\"sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm\" "
					+ "crossorigin=\"anonymous\">\r\n");
			
			out.println("<title>Login</title>");
			out.println("</head>");
			out.println("<body>");
			// Obtener una conexi�n del pool
			conn = pool.getConnection();
			stmt = conn.createStatement();
			// Recuperar los par�metros usuario y password de la petici�n request
			String usuario = request.getParameter("usuario");
			String password = request.getParameter("password");
			out.println("<div class=\"container jumbotron\">\r\n");
			out.println("<h2>Login</h2>");

			// Validar los par�metros de la petici�n request
			if(usuario.length()==0) {
				out.println("<h3>Debes introducir tu usuario</h3>");
				
			}
			else if(password.length()==0) {
				out.println("<h3>Debes introducir tu contrase�a</h3>");

			} else {
				// Verificar que existe el usuario y su correspondiente clave
				StringBuilder sqlStr = new StringBuilder();
				// sqlStr.append("SELECT * FROM usuarios WHERE ");
				sqlStr.append(" WHERE STRCMP(usuarios.nombreUsuario,'").append(usuario).append("') = 0");
				sqlStr.append(" AND STRCMP(usuarios.claveUsuario,MD5('").append(password).append("')) = 0");
								
				String where = sqlStr.toString(); 
				
				ResultSet rset = Conexiones.doSelect("usuarios","*",where);
				
				if(!rset.next()){
					// Si el resultset no est� vac�o
					out.println("<h3>Nombre de usuario o contrase�a incorrectos</h3>"); 
					out.println("<p><a href='index.html'>Volver a Login</a></p>");
					
				} else {
					// Si los datos introducidos son correctos
					// Crear una sesi�n nueva y guardar el usuario como variable de	sesi�n
					// Primero, invalida la sesi�n si ya existe
					HttpSession session = request.getSession(false);
					if(session != null) {
						session.invalidate();
					}
					session = request.getSession(true);
					synchronized(session) {
						session.setAttribute("usuario", usuario);
						session.setAttribute("idUsuario", rset.getString("idUsuario"));

					}
					
					if(usuario.contains("admin")) {
						out.println("<p>Hola, " + usuario + "! Recuerda que eres administrador</p>");
						out.println("<p><a href='inicioAdministrador.jsp' class='btn btn-success'>Pulsa para continuar aqu�</a></p>");

					} else {
						out.println("<p>Hola, " + usuario + "!</p>");
						// out.println("<p><a href='pedido.jsp?idUsuario=' class='btn btn-success' >Pulsa para continuar aqu�</a></p>");
						out.println("<p><a href='shopping' class='btn btn-success' >Pulsa para continuar aqu�</a></p>");

					}
				}
			}
			out.println("</div>\r\n");
			out.println("		<script src=\"https://code.jquery.com/jquery-3.2.1.slim.min.js\"\r\n"
					+ "			integrity=\"sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN\"\r\n"
					+ "			crossorigin=\"anonymous\"></script>\r\n");
			out.println("		<script\r\n"
					+ "			src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js\"\r\n"
					+ "			integrity=\"sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q\"\r\n"
					+ "			crossorigin=\"anonymous\"></script>\r\n");
			out.println("		<script\r\n"
					+ "			src=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js\"\r\n"
					+ "			integrity=\"sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl\"\r\n"
					+ "			crossorigin=\"anonymous\"></script>\r\n");
			out.println("</body>");
			out.println("</html>");
		} catch(SQLException ex) {
			out.println("<p>Servicio no disponible:</p>");
			out.println("<p>"+ex.getMessage()+"</p>");
			out.println("</div>\r\n");
			out.println("</body>");
			out.println("</html>");
		} finally {
			// Cerramos objetos
			out.close();
			try {
				if(stmt != null) {
					stmt.close();
				}
				if(conn != null) {
					// Esto devolver�a la conexi�n al pool
					conn.close();
				}
			}
			catch(SQLException ex){}
		}
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
} 