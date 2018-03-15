<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gelöschte Dokumente</title>

<link rel="apple-touch-icon" sizes="57x57" href="Icons/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="Icons/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="Icons/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="Icons/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="Icons/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="Icons/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="Icons/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="Icons/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="Icons/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"  href="Icons/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="Icons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="Icons/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="Icons/favicon-16x16.png">
<link rel="manifest" href="Icons/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="Icons/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">

<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gelöschte Dokumente</title>

<!-- font-awesome stylesheets -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
	
	<link rel="stylesheet" href="stylesheet.css"></link>
	

<!-- jquery datatable stylesheet bootstrap -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap.min.css"></link>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />

<!-- jquery script  -->
<script src="jquery-3.2.1.js"></script>

<!-- bootstrap javascript implementation -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- jquery datatable javascript -->
<script type="text/javascript"
	src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>



</head>
<%

System.out.println(session.getAttribute("user"));

if(session.getAttribute("user") == null){
	response.sendRedirect("Login.jsp");
}
%>
<body>
	<nav class="navbar navbar-inverse navbar-static-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#myNavbar">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="DataTableSite.jsp">EasyDoc</a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav">
				<li><a href="MeetTheTeam.jsp">Über EasyDoc</a></li>
			</ul>
			<ul class="nav navbar-nav">
				<li><a href="DataTableSite.jsp">Dokumente</a></li>

			</ul>
			<ul class="nav navbar-nav navbar-right">

				<li><a href="LogoutServlet"><span
						class="glyphicon glyphicon-log-out"></span> Abmelden</a></li>
			</ul>

		</div>
	</div>
	</nav>


	<div class="container-fluid">


		<div class="row">
			<div class="col-md-2 col-xs-0 col-lg-1"></div>
			<div class="col-md-8 col-xs-12 col-lg-10">
				<h1 class="text-center">Gelöschte Dokumente</h1>
				<table id="datatable" class="table table-striped table-bordered"
					cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>ID</th>
							<th>DateiTyp</th>
							<th>Name</th>
							<th>Autor</th>
							<th>DeleteDatum</th>
							<th>UploadDatum</th>
							<th>DokumentDatum</th>
							<th>Wiederherstellen</th>
							<th>Delete</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
			<div class="col-md-2 col-xs-0 col-lg-1"></div>
		</div>
	</div>
	<script type="text/javascript">
				
				var table = $('#datatable').DataTable({
					
					
					"processing" : true,
					"serverSide" : true,
		            "ajax" : {
					"url" : 'GeloeschteDatenServlet',
					"data" : function(act){
						act.user = '${user}';
						act.table = 'whtable';
					},
					"type" : 'POST',
						"dataSrc": "data"
					},
		            
		            
		            
					"language": {
						
							"sEmptyTable":   	"Keine Daten in der Tabelle vorhanden",
							"sInfo":         	"_START_ bis _END_ von _TOTAL_ Einträgen",
							"sInfoEmpty":    	"0 bis 0 von 0 Einträgen",
							"sInfoFiltered": 	"(gefiltert von _MAX_ Einträgen)",
							"sInfoPostFix":  	"",
							"sInfoThousands":  	".",
							"sLengthMenu":   	"_MENU_",
							"sLoadingRecords": 	"Wird geladen...",
							"sProcessing":   	"Bitte warten...",
							"sSearch":       	"<span class=\"glyphicon glyphicon-search\"></span>",
							"sZeroRecords":  	"Keine Einträge vorhanden.",
							"oPaginate": {
								"sFirst":    	"Erste",
								"sPrevious": 	"<span class=\"glyphicon glyphicon-circle-arrow-left arrowpagenav\" data-toggle=\"tooltip\" title =\"Vorherige Seite\"></span>",
								"sNext":     	"<span class=\"glyphicon glyphicon-circle-arrow-right arrowpagenav\" data-toggle=\"tooltip\" title =\"Nächste Seite\"></span>",
								"sLast":     	"Letzte"    
							},
							"oAria": {
								"sSortAscending":  ": aktivieren, um Spalte aufsteigend zu sortieren",
								"sSortDescending": ": aktivieren, um Spalte absteigend zu sortieren"
							}
						
					},


					
					

					"columns" : [ 
						{"data" : "ID"},
						{"data" : "DateiTyp"},
						{"data" : "Name"},
						{"data" : "Autor"},
						{"data" : "DeleteDatum"},
						{"data" : "UploadDatum"},
						{"data" : "DokumentDatum"},
						{"data" : "Wiederherstellen"},
						{"data" : "Delete"}
					

					],
					

			        "columnDefs": [ 
			        	{
			        		"targets": 0,
			        		"visible": false,
			        		"searchable": false
			        	},
			        	{
			            "targets": -2,
			            "data": "null",
			            "defaultContent": "<button class=\"whbutton btn-link btn-datatable\" data-toggle=\"tooltip\" title =\"Stelle dein Dokument wieder her\"><span class=\"glyphicon glyphicon-level-up\" ></span></button>"
			        },
			        {
			            "targets": -1,
			            "visible": true,
			            "searchable": false,
			            "data": "null",
			            "defaultContent": "<button class=\"deletebutton btn-link btn-datatable\" data-toggle=\"tooltip\" title =\"Hier klicken zum Löschen\"><span class=\"glyphicon glyphicon-remove\" ></span></button>"
			        },
			        {
			        	"targets": 1,
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
				        var input = $('#datatable_wrapper .dataTables_filter input').off(), //Löscht alle existierenden Listener von der Inputbox
				           self = this.api(),			// referenziert den DataTable in eine Variable, damit er innerhalb der Suchen - Funktion aufgerufen werden kann
				            $searchbutton = $('<button class=\"btn-success dttopbtn\" data-toggle=\"tooltip\" title =\"Suchen\">')	//erstellt ein Buttonobjekt
				                       .html('<span class="glyphicon glyphicon-search"/>')		// Button - Text: Suchen
				                       .click(function() {	//Funktion welche bei drücken des Buttons aufgerufen wird
				                        self.search(input.val()).draw();	//ruft die Search - Funktion des DataTables auf und aktualisiert
				                       }),
				            $deletebutton = $('<button class=\"btn-danger dttopbtn\"data-toggle=\"tooltip\" title =\"Löschen\">')	//erstellt ein Buttonobjekt
				                       .html('<span class="glyphicon glyphicon-remove"></span>')		//Button - Text: Löschen
				                       .click(function() {	//Funktion welche bei drücken des Buttons aufgerufen wird
				                          input.val('');	//Setzt den Input wieder leer
				                          $searchbutton.click(); 	//Betätigt die searchbutton - funktion, jetzt jedoch mit leerem Inhalt, zum Aktualisieren
				                       }) 
				        $('#datatable_wrapper .dataTables_filter').append($searchbutton, $deletebutton);	//Fügt beide Buttons zum DataTable hinzu
				    },
				
				});
		    	
			    $(".table tbody").on("click",".whbutton",function(){
					var sourcetable = getTableRow($(this));

			    	$.ajax({
			    		method:"POST",
			    		url:"RecreateServlet",
			    		data: {toshift: sourcetable}
			    	})
			    	.done(function(){
			    		refreshtables();
			    	})
			    	
			    });
				
			function getTableRow(acttable){
			var data;
			//console.dir(acttable);
			switch(acttable.parents(".table").attr("id")){
			case "datatable":
				data = table.row( $(acttable).parents("tr")).data();
				break;
				
			case "datatable2":{
				data = table2.row( $(acttable).parents("tr")).data();
				break;
			}
			default:
				data = "ERROR";
				break;
			}

			var str = JSON.stringify(data);
			return str;
		}
			
			function refreshtables(){
				var table = $("#datatable").DataTable();
				table.draw();
			}
			
		    $(".table tbody").on("click",".deletebutton",function(){
				var sourcetable = getTableRow($(this));

		    	//TODO: verena ändern AMK
		    	$.ajax({
		    		method:"POST",
		    		url:"DeleteComServlet",
		    		data: {tocomdelete: sourcetable}
		    	})
		    	.done(function(){
		    		refreshtables();
		    	})
		    	
		    });
			  
				
				</script>
</body>
</html>