

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.DBManager;

/**
 * Servlet implementation class ResetPasswort
 */
@WebServlet("/ResetPasswort")
public class ResetPasswort extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String username = ( (ServletRequest) request.getSession()).getParameter("username"); 
		System.out.println("Username von vorherigem Servlet:"+ username);
		//Username wird schon vom vorherigen Servlet genommen
		String pw = request.getParameter("password");
		String pw2 = request.getParameter("password2");
		String auth = (String) request.getAttribute("hashcodeverified");

		if(auth.equalsIgnoreCase("yes")) {
			if(pw.equals(pw2)) {
				if(RegisterServlet.pwdIsValid(pw)) {

					try {
						DBManager db = new DBManager();
						Connection conn=db.getConnection();

						db.PasswortNeuSetzen(null, username, pw);

						response.setContentType("text/plain");
						PrintWriter out = response.getWriter();
						out.print("pwok");

						//TODO message muss no in seite zugordnet werdn

						request.setAttribute("message", "Passwort konnte erfolgreich ge�ndert werden ");
						RequestDispatcher rd = request.getRequestDispatcher("Startseite.jsp");
						rd.forward(request, response);

					}catch(SQLException e){
						e.printStackTrace();
					} catch (InstantiationException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IllegalAccessException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
//					response.setContentType("text/plain");
//					PrintWriter out = response.getWriter();
//					out.print("pwok");
				}
				else {
//					response.setContentType("text/plain");
//					PrintWriter out = response.getWriter();
//					out.print("notsamesame");
					request.setAttribute("message", "Passw�rter stimmen nicht �berein");
					RequestDispatcher rd = request.getRequestDispatcher("ErrorPage.jsp");
					rd.forward(request, response);
				}
			}
			else {

				request.setAttribute("message", "Passwort konnte nicht ge�ndert werden ");
				RequestDispatcher rd = request.getRequestDispatcher("ErrorPage.jsp");
				rd.forward(request, response);

			}
		}
	}
}