<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<script src="dropzone.js"></script>
<link rel="stylesheet" type="text/css" href="dropzone.css" />

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

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<!-- jquery library -->
<script src="jquery-3.2.1.js"></script>


<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript" src="modalconfig.js"></script>

<title>Easy PDF - Upload</title>
</head>
<body>

	<%
	if(session.getAttribute("username")== null){
		response.sendRedirect("Login.jsp");
		//TODO kurze INFO an Benutzer? 
	}
	%>


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
					<button id="overwritebtn" class="btn btn-primary">Überschreibe
						die Datei</button>
				</div>
				<div class="modal-footer"></div>
			</div>

		</div>
	</div>


	<h1>Willkommen auf der Upload Seite</h1>


	<h1>Bitte hier Dateien die abgelegt werden sollen hineinziehen:</h1>

	<script>
		Dropzone.myDropzone = false;
		var size = 1;
		var name;
		Dropzone.options.myDropzone = {

			init : function() {
				var dropzone = this;
				var filetogive;
				var givename;
				var tochange;
				var overwrite = false;

				function getDokumentNamen(namedatei) {

					$.getJSON("DateienListServlet", function(responseText) { // Execute Ajax GET request on URL of "someservlet" and execute the following function with Ajax response text...
						var DokumentNamen = responseText;

						console.log(DokumentNamen);
						console.log(namedatei);
						var vorhanden = $.inArray(namedatei, DokumentNamen);
						console.log(vorhanden);

						if (vorhanden === -1) {
							console.log("nicht vorhanden");
							sendfile();
						} else {
							console.log("vorhanden");
							addChecker(DokumentNamen);
							showModal(namedatei);
							console.log(DokumentNamen);

						}
					});

				}

				this.on("addedfile", function(file) {
					tochange = file.previewElement
							.querySelector("[data-dz-name]");
					givename = file.name;
					console.log(givename);
					getDokumentNamen(givename);
					filetogive = file;
					console.log(file);
				});

				$("#overwritebtn").on("click", function() {
					overwrite = true;
					sendfile();
					$("#saveModal").modal("hide");
				})

				$("#modalinputbtn").on("click", function() {
					console.log("filetogive");
					givename = $("#modalinput").val();
					tochange.innerHTML = givename;
					dropzone.processFile(filetogive);
					$("#saveModal").modal("hide");
				});

				function sendfile() {
					console.log("sendingstatus");
					console.log(filetogive.status);
					if (filetogive.status != "error") {
						dropzone.processFile(filetogive);
					}

				}

				this.on("renameFile", function(file) {
					alert("called renameFile");
				});

				this.on("sending", function(file, xhr, formData) {
					console.log("sending called");
					formData.append("dateiname", givename);
					formData.append("overwrite", overwrite);
					overwrite = false;
				});
				
				this.on("success",function(file){
					console.log("success");
				});
				this.on("complete",function(file){
					console.log("complete");
				});
				this.on("uploadprogress",function(file,progress,bytesSent){
					console.log("progress: "+progress+" | "+bytesSent);
				});

				console.log("finished init");
			},
			maxFilesize : size,
			paramName : "pdffile",
			url : "UploadServlet",
			acceptedFiles : "application/pdf,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,text/plain",
			parallelUploads : 1,
			autoQueue : false,
			autoProcessQueue : false,
			dictDefaultMessage : "Ziehe Dateien hierhin zum Hochladen",
			dictFallbackMessage : "Dieser Browser wird leider nicht unterstützt",
			dictFileTooBig : "Die Datei ist leider zu groß. Erlaubtes Maximum sind "
					+ size + " MB",
			dictInvalidFileType : "Dies ist leider der falsche Dateityp. Es werden nur PDF-Dateien unterstützt"

		}

		console.log("finished javascript")
	</script>

	<div>
		<form action="UploadServlet" method="post"
			enctype="multipart/form-data" name="pdffile" id="my-dropzone"
			class="dropzone">
			<input type="hidden" name="dateiname" id="dateiname"></input>

		</form>

		<form action="LogoutServlet">
			<input type="submit" value="Logout"></input>
		</form>

		<div>
			<form action="LogoutServlet">
				<input type="submit" value="Logout"></input>
			</form>
		</div>
	</div>


</body>
</html>