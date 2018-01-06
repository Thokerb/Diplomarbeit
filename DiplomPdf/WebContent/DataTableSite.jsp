<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>

<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />

<title>Easy PDF - Files </title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<!-- font-awesome stylesheets -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

<link rel="stylesheet" href="stylesheet.css"></link>

<!-- jquery datatable stylesheet bootstrap -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap.min.css"></link>

<!-- dropzone js und stylesheet -->
<script src="dropzone.js"></script>
<link rel="stylesheet" type="text/css" href="dropzone.css" />


</head>

<%
if(session.getAttribute("username")== null){
//response.sendRedirect("Login.jsp");
}
%>
<body>

	<!-- jquery script  -->
	<script src="jquery-3.2.1.js"></script>



	<!-- bootstrap implementation -->
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<!-- jquery datatable javascript -->
	<script type="text/javascript"
		src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>


	<script type="text/javascript">

	$(document).ready(function() {

		//aktiviert Tooltip
	    $('[data-toggle="tooltip"]').tooltip(); 
        
        var table2 = $("#datatable2").DataTable({
            "processing" : true,
			"serverSide" : true,
            "ajax" : {
			"url" : '/DiplomPdf/DataTableServlet',
			"type" : 'POST',
			"dataSrc": "data"
			},
			
			"language": {
				
				"sEmptyTable":   	"Keine Daten in der Tabelle vorhanden",
				"sInfo":         	"_START_ bis _END_ von _TOTAL_ Eintr�gen",
				"sInfoEmpty":    	"0 bis 0 von 0 Eintr�gen",
				"sInfoFiltered": 	"(gefiltert von _MAX_ Eintr�gen)",
				"sInfoPostFix":  	"",
				"sInfoThousands":  	".",
				"sLengthMenu":   	"_MENU_",
				"sLoadingRecords": 	"Wird geladen...",
				"sProcessing":   	"Bitte warten...",
				"sSearch":       	"<span class=\"glyphicon glyphicon-search\"></span>",
				"sZeroRecords":  	"Keine Eintr�ge vorhanden.",
				"oPaginate": {
					"sFirst":    	"Erste",
					"sPrevious": 	"<span class=\"glyphicon glyphicon-circle-arrow-left arrowpagenav\" data-toggle=\"tooltip\" title =\"Vorherige Seite\"></span>",
					"sNext":     	"<span class=\"glyphicon glyphicon-circle-arrow-right arrowpagenav\" data-toggle=\"tooltip\" title =\"N�chste Seite\"></span>",
					"sLast":     	"Letzte"    
				},
				"oAria": {
					"sSortAscending":  ": aktivieren, um Spalte aufsteigend zu sortieren",
					"sSortDescending": ": aktivieren, um Spalte absteigend zu sortieren"
				}
			
		},
            
			"columns" : [ 
				{"data" : "DateiTyp"},
				{"data" : "Name"},
				{"data" : "Autor"},
				{"data" : "UploadDatum"},
				{"data" : "DokumentDatum"},
				{"data" : "Download"},
				{"data" : "Delete"}
			

			],
			

	        "columnDefs": [ {
	        	"targets": -2,
	            "data": "null",
	            "defaultContent": "<button class=\"downloadbutton btn-link btn-datatable\" data-toggle=\"tooltip\" title =\"Hier klicken zum Downloaden\"><span class=\"glyphicon glyphicon-arrow-down\" ></span></button>"
	        }, {
	            "targets": -1,
	            "data": "null",
	            "defaultContent": "<button class=\"deletebutton btn-link btn-datatable\" data-toggle=\"tooltip\" title =\"Hier klicken zum L�schen\"><span class=\"glyphicon glyphicon-remove\" ></span></button>"
	        },
	        {
	        	"targets": 0,
	        	"render": function func(data){
	        		console.log(data);
	        		var text = "";
	        		switch(data){
	        		case "PDF":
	        			text = "<span class=\"fa fa-file-pdf-o icontype\" ></span>";
	        			break;
	        		case "TXT":
	        			text = "<span class=\"fa fa-file-text-o	\" ></span>";
	        			break;
	        		case "DOC":
	        			text = "<span class=\"fa fa-file-word-o	 icontype\" ></span>";
	        			break;
	        		case "DOCX":
	        			text = "<span class=\"fa fa-file-word-o	 icontype\" ></span>";
	        			break;
	        		default:
	        			text = "<span class=\"fa fa-question icontype\" ></span>";
	        			break;
	        		}
	        		return text;
	        	}
	        	
	        }],   
	        
	        
		    initComplete : function() {		// wird aufgerufen, wenn der DataTable fertig geladen ist
		        var input = $('#datatable2_wrapper .dataTables_filter input').off(), //L�scht alle existierenden Listener von der Inputbox
		           self = this.api(),			// referenziert den DataTable in eine Variable, damit er innerhalb der Suchen - Funktion aufgerufen werden kann
		            $searchbutton = $('<button class=\"btn-success dttopbtn\" data-toggle=\"tooltip\" title =\"Suchen\">')	//erstellt ein Buttonobjekt
		                       .html('<span class="glyphicon glyphicon-search"/>')		// Button - Text: Suchen
		                       .click(function() {	//Funktion welche bei dr�cken des Buttons aufgerufen wird
		                        self.search(input.val()).draw();	//ruft die Search - Funktion des DataTables auf und aktualisiert
		                       }),
		            $deletebutton = $('<button class=\"btn-danger dttopbtn\"data-toggle=\"tooltip\" title =\"L�schen\">')	//erstellt ein Buttonobjekt
		                       .html('<span class="glyphicon glyphicon-remove"></span>')		//Button - Text: L�schen
		                       .click(function() {	//Funktion welche bei dr�cken des Buttons aufgerufen wird
		                          input.val('');	//Setzt den Input wieder leer
		                          $searchbutton.click(); 	//Bet�tigt die searchbutton - funktion, jetzt jedoch mit leerem Inhalt, zum Aktualisieren
		                       }) 
		        $('#datatable2_wrapper .dataTables_filter').append($searchbutton, $deletebutton);	//F�gt beide Buttons zum DataTable hinzu
		    },
            
            
        });
        

		var table = $('#datatable').DataTable({
			
		
			"processing" : true,
			"serverSide" : true,
            "ajax" : {
			"url" : '/DiplomPdf/DataTableServlet',
			"type" : 'POST',
				"dataSrc": "data"
			},
            
            
            
			"language": {
				
					"sEmptyTable":   	"Keine Daten in der Tabelle vorhanden",
					"sInfo":         	"_START_ bis _END_ von _TOTAL_ Eintr�gen",
					"sInfoEmpty":    	"0 bis 0 von 0 Eintr�gen",
					"sInfoFiltered": 	"(gefiltert von _MAX_ Eintr�gen)",
					"sInfoPostFix":  	"",
					"sInfoThousands":  	".",
					"sLengthMenu":   	"_MENU_",
					"sLoadingRecords": 	"Wird geladen...",
					"sProcessing":   	"Bitte warten...",
					"sSearch":       	"<span class=\"glyphicon glyphicon-search\"></span>",
					"sZeroRecords":  	"Keine Eintr�ge vorhanden.",
					"oPaginate": {
						"sFirst":    	"Erste",
						"sPrevious": 	"<span class=\"glyphicon glyphicon-circle-arrow-left arrowpagenav\" data-toggle=\"tooltip\" title =\"Vorherige Seite\"></span>",
						"sNext":     	"<span class=\"glyphicon glyphicon-circle-arrow-right arrowpagenav\" data-toggle=\"tooltip\" title =\"N�chste Seite\"></span>",
						"sLast":     	"Letzte"    
					},
					"oAria": {
						"sSortAscending":  ": aktivieren, um Spalte aufsteigend zu sortieren",
						"sSortDescending": ": aktivieren, um Spalte absteigend zu sortieren"
					}
				
			},


			
			

			"columns" : [ 
				{"data" : "DateiTyp"},
				{"data" : "Name"},
				{"data" : "Autor"},
				{"data" : "UploadDatum"},
				{"data" : "DokumentDatum"},
				{"data" : "Download"},
				{"data" : "Delete"}
			

			],
			

	        "columnDefs": [ {
	        	"targets": -2,
	            "data": "null",
	            "defaultContent": "<button class=\"downloadbutton btn-link btn-datatable\" data-toggle=\"tooltip\" title =\"Hier klicken zum Downloaden\"><span class=\"glyphicon glyphicon-arrow-down\" ></span></button>"
	        }, {
	            "targets": -1,
	            "data": "null",
	            "defaultContent": "<button class=\"deletebutton btn-link btn-datatable\" data-toggle=\"tooltip\" title =\"Hier klicken zum L�schen\"><span class=\"glyphicon glyphicon-remove\" ></span></button>"
	        },
	        {
	        	"targets": 0,
	        	"render": function func(data){
	        		console.log(data);
	        		var text = "";
	        		switch(data){
	        		case "PDF":
	        			text = "<span class=\"fa fa-file-pdf-o icontype\" ></span>";
	        			break;
	        		case "TXT":
	        			text = "<span class=\"fa fa-file-text-o	\" ></span>";
	        			break;
	        		case "DOC":
	        			text = "<span class=\"fa fa-file-word-o	 icontype\" ></span>";
	        			break;
	        		case "DOCX":
	        			text = "<span class=\"fa fa-file-word-o	 icontype\" ></span>";
	        			break;
	        		default:
	        			text = "<span class=\"fa fa-question icontype\" ></span>";
	        			break;
	        		}
	        		return text;
	        	}
	        	
	        }
	        ],

	        

	        
	        
			
			
		    initComplete : function() {		// wird aufgerufen, wenn der DataTable fertig geladen ist
		        var input = $('#datatable_wrapper .dataTables_filter input').off(), //L�scht alle existierenden Listener von der Inputbox
		           self = this.api(),			// referenziert den DataTable in eine Variable, damit er innerhalb der Suchen - Funktion aufgerufen werden kann
		            $searchbutton = $('<button class=\"btn-success dttopbtn\" data-toggle=\"tooltip\" title =\"Suchen\">')	//erstellt ein Buttonobjekt
		                       .html('<span class="glyphicon glyphicon-search"/>')		// Button - Text: Suchen
		                       .click(function() {	//Funktion welche bei dr�cken des Buttons aufgerufen wird
		                        self.search(input.val()).draw();	//ruft die Search - Funktion des DataTables auf und aktualisiert
		                       }),
		            $deletebutton = $('<button class=\"btn-danger dttopbtn\"data-toggle=\"tooltip\" title =\"L�schen\">')	//erstellt ein Buttonobjekt
		                       .html('<span class="glyphicon glyphicon-remove"></span>')		//Button - Text: L�schen
		                       .click(function() {	//Funktion welche bei dr�cken des Buttons aufgerufen wird
		                          input.val('');	//Setzt den Input wieder leer
		                          $searchbutton.click(); 	//Bet�tigt die searchbutton - funktion, jetzt jedoch mit leerem Inhalt, zum Aktualisieren
		                       }) 
		        $('#datatable_wrapper .dataTables_filter').append($searchbutton, $deletebutton);	//F�gt beide Buttons zum DataTable hinzu
		    },
			
			

		});

	    $('.table tbody').on( 'click', '.downloadbutton', function () {
	    	console.log("downloadbutton geklickt");

	    	var position = $(this).parents("td");
	    	console.log(position);
	    	var y = $("<div class='animate'>Download</div>");
	    	position.append(y);
            y.animate({
				left: "-100px",
				bottom: "-100px"
            });
            setTimeout(function () {
				y.remove();
            },5000);

            
            var data = table.row( $(this).parents("tr")).data();
	         var str = JSON.stringify(data);
		     	var xhttp = new XMLHttpRequest();
			
	     	xhttp.open("POST", "DownloadServlet", true);
	    	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	    	xhttp.send("download="+str);
	         

	    	
	    });
	    
        
	    
	    
	    $(".table tbody").on("click",".deletebutton",function(){
            var info2 = $(this).parents(".table").attr("id");
        //aktuell primitiv gehardcoded,eventuell switch �nderung. Je nach anzahl an tabellen    
            if(info2 === "datatable"){
                    var data = table.row( $(this).parents("tr")).data();
            }
            else{
                if(info2 === "datatable2"){
                      var data = table2.row( $(this).parents("tr")).data();
                }
                else{
                    console.log("SCHWERER FEHLER !")
                }
            }
            
	    //    var data = table.row( $(this).parents("tr")).data();
	        var str = JSON.stringify(data);
            var sourcetable = JSON.stringify(info2);
	        console.log(str);
	     	var xhttp = new XMLHttpRequest();
	    	xhttp.open("POST","DeleteServlet",true);
	    	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	    	xhttp.send("todelete="+str+sourcetable);
            
	    	refreshtables();
	    });
		
	    
	    	$(".table tbody").on('mouseenter','.glyphicon-arrow-down',function(){
	    		console.log("enter");
	    		$(this).addClass("iconeffect");

	    	});
	    	


		
 		$(".table tbody").on("webkitAnimationEnd mozAnimationEnd animationEnd",".glyphicon-arrow-down",function(){
			console.log("called");
			$(this).removeClass("iconeffect");
		}); 
		
		$(".uploadmodalbtn").on("click",function(){
			alert("TODO: UPLOAD MODAL ERSCHEINEN LASSEN")
		});
		
		function refreshtables(){
			table.draw();
			table2.draw();
		}
		
		console.log("finished  js init");
	});
	



	
</script>

	<script type="text/javascript" src="dropzoneconfig.js" charset="UTF-8"></script>
	<script src="modalconfig.js"></script>

	<nav class="navbar navbar-inverse navbar-static-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#myNavbar">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">EasyPDF</a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav">
				<li><a href="#">Gel�schte Dokumente</a></li>
				<li><a href="#">Verlauf</a></li>
				<li><a href="MeetTheTeam.jsp">�ber EasyPDF</a></li>
			</ul>
			<button type="button" class="btn btn-info  navbar-btn"
				data-toggle="modal" data-target="#uploadModal">UPLOAD</button>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="Startseite.jsp"><span
						class="glyphicon glyphicon-log-out"></span> Abmelden</a></li>
			</ul>
		</div>
	</div>
	</nav>
	<div class="container-fluid">


		<div class="row">
			<div class="col-md-2 col-xs-0 col-lg-1"></div>
			<div class="col-md-8 col-xs-12 col-lg-10">
				<h1 class="text-center">Meine Dokumente</h1>
				<table id="datatable" class="table table-striped table-bordered"
					cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>DateiTyp</th>
							<th>Name</th>
							<th>Autor</th>
							<th>UploadDatum</th>
							<th>DokumentDatum</th>
							<th>Download</th>
							<th>Delete</th>
						</tr>

					</thead>
					<tbody>

					</tbody>
				</table>


			</div>
			<div class="col-md-2 col-xs-0 col-lg-1"></div>
		</div>

		<div class="row">
			<div class="col-xs-0 col-md-2 col-lg-1"></div>
			<div class="col-xs-12 col-md-8 col-lg-10">
				<h1 class="text-center">Zuletzt verwendet</h1>
				<table id="datatable2" class="table table-striped table-bordered"
					cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>DateiTyp</th>
							<th>Name</th>
							<th>Autor</th>
							<th>UploadDatum</th>
							<th>DokumentDatum</th>
							<th>Download</th>
							<th>Delete</th>
						</tr>

					</thead>
					<tbody>


					</tbody>
				</table>
			</div>
			<div class="col-xs-0 col-md-2 col-lg-1"></div>

		</div>

	</div>


	<!-- Modal -->
	<div id="uploadModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Lade dein Dokument hoch</h4>
				</div>
				<div class="modal-body">
					<h2 id="modalueberschrift">Ziehe dein Dokument hier hinein um es hochzuladen</h2>
					<form action="UploadServlet" method="post"
						enctype="multipart/form-data" name="pdffile" id="my-dropzone"
						class="dropzone">
						<input type="hidden" name="dateiname" id="dateiname"></input>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>


	<!-- Modal -->
	<div id="saveModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Modal Header</h4>
				</div>
				<div class="modal-body">
					<p>
						Der Name <span id="modaldatname"></span> ist bereits vorhanden
					</p>
					<p>Bitte gib einen neuen Namen ein:</p>
					<input id="modalinput" />
					<button disabled="true" class="btn btn-primary disabled"
						id="modalinputbtn">OK</button>
					<button id="overwritebtn" class="btn btn-primary">�berschreibe
						die Datei</button>
				</div>
				<div class="modal-footer"></div>
			</div>

		</div>
	</div>




</body>
</html>