

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		String todelete = request.getParameter("todelete");
		System.out.println("todelete: "+todelete);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
