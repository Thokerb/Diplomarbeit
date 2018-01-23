import java.io.IOException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DBManager;

/**
 * Servlet implementation class EmailPasswort
 */
@WebServlet("/EmailPasswort")
public class EmailPasswort extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		final String username = "easypdf.help@gmail.com";
		final String password = "htlanichstr";
		
		try {
			DBManager db = new DBManager();
			String user = request.getParameter("username");
			String emailuser = request.getParameter("email");
			
			String checkemail = db.getEmailByUser(user); 
			String checkuser = db.getUserByEmail(emailuser);
			String getuser = db.getUser(user);
			String getemail = db.getEmail(email);

			emailuser = "sari.hindelang@gmail.com";
			
		} catch (InstantiationException | IllegalAccessException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		//		
		response.setContentType("text/html");

		//		if((getuser == null) || (getemail == null)){
		//			request.getSession().setAttribute("false", "Email und Userkennung stimmen nich �berein!");
		//		System.out.println("User existiert nicht, Mail kann nicht versendet werden. . . ");
		//			response.sendRedirect("checkforgotpassword.jsp");
		//		}else{

		System.out.println("User existiert, Mail kann versendet werden. . . ");

		Properties props = new Properties();

		props.put("mail.smtp.user","username"); 
		props.put("mail.smtp.host", "smtp.gmail.com"); 
		props.put("mail.smtp.auth", "true"); 
		props.put("mail.smtp.starttls.enable","true"); 
		props.put("mail.smtp.EnableSSL.enable","true");

		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");   
		props.setProperty("mail.smtp.socketFactory.fallback", "false");   
		props.setProperty("mail.smtp.port", "465");   
		props.setProperty("mail.smtp.socketFactory.port", "465"); 

		Session session = Session.getInstance(props,
				new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});
		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("easypdf.help@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(emailuser));
			message.setSubject("Passwort zur�cksetzen EasyPDF");
			message.setText("Lieber EasyPDF Nutzer, um dein Passwort zur�ckzusetzten bitte folgenden Link �ffnen: "
					+ "\n\n http://localhost:8080/DiplomPdf/Login.jsp"
					+"\n\n  Viel Spa� bei der weiteren Nutzung von EasyPDF w�nscht das TEAM: "
					+ "\n\n \n\n \t Thomas Kerber, Verena Gurtner & Sara Hindelang"); //TODO noch �ndern in JSP PWzuruck

			Transport.send(message);

			System.out.println("Email wurde versendet");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}

	//	}

	class GMailAuthenticator extends Authenticator {
		String user;
		String pw;
		public GMailAuthenticator (String username, String password)
		{
			super();
			this.user = username;
			this.pw = password;
		}
		public PasswordAuthentication getPasswordAuthentication()
		{
			System.out.println("GMail Auth OK");
			return new PasswordAuthentication(user, pw);
		}
	}
}
