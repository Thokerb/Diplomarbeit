

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import model.DBManager;
import model.Daten;

/**
 * Servlet implementation class DeleteServlet
 */
@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	//	response.getWriter().append("Served at: ").append(request.getContextPath());
		/**
		 * Hier werden die Daten der Datei geschickt, welche gel�scht werden sollen
		 * F�r ein Beispiel testjquery.html �ffnen und auf den delete button klicken4
		 * TODO: aus DB l�schen aber darauf achten, dass nicht zu schnell gel�scht wird.
		 * evtl reihenfolge vorgeben zuerst db dann aus seite l�schen? 
		 */
		String toshift = request.getParameter("toshift");
		System.out.println("toshift: "+toshift);
		
		Gson gsn = new Gson();
		JsonObject jobj; 

		jobj = gsn.fromJson(toshift, JsonObject.class);
		String idObj = jobj.get("ID").getAsString();
		int id = Integer.parseInt(idObj);
		System.out.println("toshift:"+id);
		String autor = jobj.get("Autor").getAsString();
		HttpSession ses = request.getSession(false);
		String username = (String) ses.getAttribute("user"); //Username wird vom vorherigen Servlet genommen
		
		Daten uploaddaten = new Daten();

		if(username.equals(autor)){
			try {
				System.out.println("PENIS PENIS PENis");
				
				DBManager db = new DBManager();
				Connection conn=db.getConnection();
				uploaddaten=db.readzuloeschendeDatei(conn,id);
				db.Datenl�schen(conn,id,"uploaddaten");
				db.writegeloeschteDaten(conn, uploaddaten);
				System.out.println("PENIS PENIS PENSI");
			} catch (InstantiationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else{
			System.out.println("Verschieben nicht erlaubt");
			//TODO:Antwort an Client senden? 
		}		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
