package es.studium.PracticaTema4;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.sql.DataSource;

// Clase creada para crear consultas
public class Conexiones {
	private static DataSource pool;

	// Método para realizar consultas SELECT
	public static ResultSet doSelect(String objeto, String campos, String where) throws ServletException, SQLException {
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
		
		Connection conn = null;
		Statement stmt = null;

		conn = pool.getConnection();
		stmt = conn.createStatement();
		StringBuilder sqlStr = new StringBuilder();

		sqlStr.append("SELECT "+campos+" FROM "+objeto+" "+where+" ;");
		
		System.out.println(sqlStr.toString());
		ResultSet rset = stmt.executeQuery(sqlStr.toString());
		return rset;
	}
	
	public static void doInsert(String objeto, String campos, String values) throws ServletException, SQLException {
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
		
		Connection conn = null;
		Statement stmt = null;

		conn = pool.getConnection();
		stmt = conn.createStatement();

		String query = "INSERT INTO "+objeto+" ("+campos+") VALUES ("+values+") ;";
		System.out.println(query);
		stmt.executeUpdate(query);
	}
	
	public static void doUpdate(String objeto,String sets, String where) throws ServletException, SQLException {
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
		
		Connection conn = null;
		Statement stmt = null;

		conn = pool.getConnection();
		stmt = conn.createStatement();
		StringBuilder sqlStr = new StringBuilder();

		sqlStr.append("UPDATE "+objeto+" SET "+sets+" WHERE "+where+" ;");
		System.out.println(sqlStr.toString());
		stmt.executeUpdate(sqlStr.toString());
	}
	
	
	

}
