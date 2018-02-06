import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import model.DBManager;

/**
 * Servlet implementation class UploadServlet
 */
//@WebServlet("/UploadServlet")
//@MultipartConfig

public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UploadServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/**
		 * Aktuell wird die Datei tempor�r auf C:/Temp gespeichert --> sp�ter dann alles �ber DB
		 * wenn boolean overwrite true ist, dann gibt es die datei bereit und sie soll �berschrieben werden
		 * TODO: �bergabe in DATENBANK
		 */
		int nummer = 1;
		Part filePart = request.getPart("pdffile"); // Retrieves <input type="file" name="file">	
		System.out.println(filePart);
		InputStream fileContent = filePart.getInputStream();
		System.out.println("was steht da: "+filePart.getHeader("content-disposition").substring(36));  //TODO substring 36?
		String user = request.getParameter("username");
		System.out.println(user);
		
		boolean overwrite = Boolean.parseBoolean(request.getParameter("overwrite"));	//nimmt den String und wandelt ihn in ein boolean um
		String dateiname = request.getParameter("dateiname");
		System.out.println("Name der Datei: "+dateiname+" overwrite: "+overwrite);

		uploader(fileContent,dateiname,0);
		fileContent.close();
		fileContent = null;
		File f = new File(dateiname);
		String name = f.getName();

		String dateityp=name.substring(name.lastIndexOf('.')+1,name.length());
		dateityp = dateityp.toUpperCase();
		System.out.println("Es handelt sich um eine ' "+ dateityp +" ' Datei: ");
		System.out.println("-----------------------------------------");
		
		HttpSession ses = request.getSession(false); //TODO: if 
		String username = (String) ses.getAttribute("user");
		
		if(overwrite){
			try {
				DBManager dbm = new DBManager();
				Connection conn = dbm.getConnection();	//TODO: OVERWRITE TESTEN
				dbm.deletebyname(dateiname,conn);
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
		

		switch(dateityp){

		case "PDF"  :{
			String inhalttext = PDFboxLesen.lesenPDF("C://Temp//"+dateiname); //file objekt mit dems
			//TODO Autor und Datum ausbessern
			try {
				DBManager dbm=new DBManager();
				Connection conn1=dbm.getConnection();
				String stichworttext=dbm.Stichtextgenerator(conn1,inhalttext);
				//tag, inhalttext, uploader, autor, dateiname, uploaddatum, stichworttext, dateityp
				String[] daten =new String[8];
				daten[0]="tag";
				daten[1]=inhalttext;
				daten[2]=username;
				daten[3]=PDFmanager.getAutor(); //Uploader von Thomas Seite
				daten[4]=dateiname;
				daten[5]= PDFmanager.getDatum(); //da sollt ma "getDatum(Calendar cal)" was vom typ calender verwenden dann sollts richtge anzeigen
				//PDFmanager.convDatum(daten[5);]
				daten[6]=dateityp;
				
				for(String s : daten) {
					System.out.print("Gelesen wurde: ");
					System.out.println(s);
				}
				DBManager.writeDaten(conn1,daten,filePart,PDFmanager.getDatum());
				//DBManager.Blobeinfuegen(filePart,stichworttext);
				
				dbm.releaseConnection(conn1);
				System.out.println(inhalttext);
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch(SQLException e){
				e.printStackTrace();
			}

			System.out.println("PDF - Datei wurde in Text umgewandelt + Weitergabe an DB");
			break;
		}

		case "TXT"  :{

			TextdateiLesen.textdateiLesen("C://Temp//"+dateiname);

			//TODO in Datenbank speichern

			System.out.println("Txt - Datei wurde in Text umgewandelt -> Weitergeben an DB (Achtung, keine Metadaten vorhanden)");
			break; 
		}

		case "DOC"  :{

			String inhalttext=DocLesen.lesenDoc("C://Temp//"+dateiname);
//			. getAutor() -- String -  .getDatum() -- String - f�r Infos verwenden

			//TODO alles ausbessern
			try {
				DBManager dbm=new DBManager();
				Connection conn1=dbm.getConnection();
				String stichworttext=dbm.Stichtextgenerator(conn1,inhalttext);
				//tag, inhalttext, uploader, autor, dateiname, uploaddatum, stichworttext, dateityp
				String[] daten =new String[8];
				daten[0]="tag";
				daten[1]=inhalttext;
				daten[2]=username;
				daten[3]=PDFmanager.getAutor(); //Uploader von Thomas Seite
				daten[4]=dateiname;
				daten[5]=stichworttext; //da sollt ma "getDatum(Calendar cal)" was vom typ calender verwenden dann sollts richtge anzeigen
				//PDFmanager.convDatum(daten[5);]
				daten[6]=dateityp;

				for(String s : daten) {
					System.out.print("Gelesen wurde: ");
					System.out.println(s);
				}
				DBManager.writeDaten(conn1,daten,filePart,DocLesen.getDatum());
				//DBManager.Blobeinfuegen(filePart,stichworttext);
				
				dbm.releaseConnection(conn1);
				System.out.println("inhalttext");
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch(SQLException e){
				e.printStackTrace();
			}


			System.out.println("Doc - Datei wurde in Text umgewandelt -> Weitergeben an DB");
			break; 
		}

		case "DOCX"  :{

			String inhalttext=DocxLesen.lesenDocx("C://Temp//"+dateiname);
//			. getAutor() -- String -  .getDatum() -- String - f�r Infos verwenden

			//TODO alles ausbessern
			try {
				DBManager dbm=new DBManager();
				Connection conn1=dbm.getConnection();
				String stichworttext=dbm.Stichtextgenerator(conn1,inhalttext);
				//tag, inhalttext, uploader, autor, dateiname, uploaddatum, stichworttext, dateityp
				String[] daten =new String[8];
				daten[0]="tag";
				daten[1]=inhalttext;
				daten[2]=username;
				daten[3]=PDFmanager.getAutor(); 
				daten[4]=dateiname;
				daten[5]=stichworttext;
				daten[6]=dateityp;
//				daten[8]= DocxLesen.getDatum();
//				daten[9]= DocxLesen.getDatum();

				for(String s : daten) {
					System.out.print("Gelesen wurde: ");
					System.out.println(s);
				}
				DBManager.writeDaten(conn1,daten,filePart,DocxLesen.getDate());
				//DBManager.Blobeinfuegen(filePart,stichworttext);
				
				dbm.releaseConnection(conn1);
				System.out.println("inhalttext");
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch(SQLException e){
				e.printStackTrace();
			}

			System.out.println("Docx - Datei wurde in Text umgewandelt -> Weitergeben an DB");
			break; 
		}

		default:{

			System.out.println("Datei kann nicht gespeichert werden, Dateityp "+ dateityp +"wird nicht unterst�tzt");
		}



		}
		/*
        String pfad =getInitParameter("Pfad");
        File file = createFile(pfad, dateiname);
        try{
            Files.copy(fileContent, file.toPath());
        }	
        catch(Exception ex){
        	System.out.println("ERROR DATEI BEREITS VORHANDEN");
        }
		 */
		
		Files.deleteIfExists(Paths.get("C://Temp//"+dateiname));
		
//		System.out.println("Datei fertig eingelesen (noch nicht ganz DB speicherung fehlt bis jetzt )");
//		f.mkdir();
//		f.setExecutable(true, false);
//		f.setReadable(true, false);
//		f.setWritable(true, false);
//		System.out.println("was steht da333"+f.exists()+ f.canRead()+ f.canWrite()+ f.canExecute());
//		System.gc();
//		System.out.println("l�schen geht:"+f.delete()); // ture zur�ck, tdm vorhanden
//		System.gc();
	//	f.deleteOnExit();
		
	
	}

	private void uploader(InputStream fileContent, String dateiname,int nummer){

		String pfad = getInitParameter("Pfad");
		File file = createFile(pfad, dateiname);

		try{
			Files.copy(fileContent, file.toPath());
			System.out.println("Datei gespeichert. Sie war bisher "+nummer+" mal vorhanden");

		}	
		catch(Exception ex){
			System.out.println("ERROR DATEI BEREITS VORHANDEN");
			nummer++;
			uploader(fileContent, NamensNummerierer(dateiname,nummer),nummer);
		}
		finally {
			try {
				fileContent.close();
				fileContent = null;
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	private File createFile(String pfad, String name){
		File uploads = new File(pfad);
		File file = new File(uploads, name);
		return file;

	}

	private String NamensNummerierer(String name,int nummer){

		String nameneu;
		String dateitypneu = name.substring(name.lastIndexOf('.')+1,name.length());
		dateitypneu = dateitypneu.toUpperCase();

		switch(dateitypneu) {
		case "PDF": {
			nameneu = name;
			nameneu = name.substring(0,name.length()-4);
			nameneu = nameneu+"("+nummer+")"+".pdf";
			return nameneu; 
		}
		case "DOC": {
			nameneu = name;
			nameneu = name.substring(0,name.length()-4);
			nameneu = nameneu+"("+nummer+")"+".doc";
			return nameneu; 
		}
		case "DOCX": {
			nameneu = name;
			nameneu = name.substring(0,name.length()-5); // 5 ?
			nameneu = nameneu+"("+nummer+")"+".docx";
			return nameneu; 
		}
		case "TXT": {
			nameneu = name;
			nameneu = name.substring(0,name.length()-4);
			nameneu = nameneu+"("+nummer+")"+".txt";
			return nameneu;
		}
		default:{
			System.out.println("Neuer Name konnte nicht vergeben werden, Dateityp wird nicht unterstuetzt");
		}

		}
		return null;
	}
}
