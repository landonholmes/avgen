
<html>
  <head>
    <title>Avatar Generator</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
	<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<script src="jscolor/jscolor.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  </head>
  <body>
	<cfoutput>
	    <div class="container">
		    <h2>Create an Avatar Image</h2>
		    <div class="row">&nbsp;</div>
		    <div class="row">
			    <div class="col-md-4">
					<form class="form-horizontal" id="avatarForm">
                        <div class="form-group">
                            <label class="control-label col-md-6" for="backgroundColor">Background Color:</label>
                            <div class="col-md-6">
                                <input type="backgroundColor" id="backgroundColor" name="backgroundColor" class="form-control color" value="" />
                            </div>
                        </div>
						<div class="form-group">
							<label class="control-label col-md-6" for="imageText">Text:</label>
							<div class="col-md-6">
								<input type="text" id="imageText" name="imageText" class="form-control" value="HI" maxlength="3"/>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-6" for="textColor">Text Color:</label>
							<div class="col-md-6">
								<input type="textColor" id="textColor" name="textColor" class="form-control color" value="000000" />
							</div>
						</div>
                        <div class="form-group">
                            <label class="control-label col-md-6" for="font">Text Color:</label>
                            <div class="col-md-6">
	                            <select name="fontFamily" class="form-control ">
		                            <option style="font-family: Arial;" value="Arial">Arial</option>
		                            <option style="font-family: Courier New;" value="Courier New">Courier New</option>
		                            <option style="font-family: Lucida Sans Typewriter;" value="Lucida Sans Typewriter">Lucida Sans Typewriter</option>
	                            </select>
                            </div>
                        </div>
						<div class="form-group">
							<div class="col-md-offset-2 col-md-6">
								<button type="button" class="btn btn-sm btn-primary doThings">Do Things</button>
                                <a href="out/avatar.png" type="button" class="btn btn-md btn-info" id="downloadButton" download="avatar.png"><i class="glyphicon glyphicon-download-alt"></i></a>
							</div>
						</div>
					</form>
			    </div>
                <div class="col-md-8">
	                <div class="row">
                        <img class="img-thumbnail avatarImage" style="max-width: 150px;" src="out/avatar.png" />
                        <img class="img-thumbnail avatarImage" style="max-width: 100px;" src="out/avatar.png" />
                        <img class="img-thumbnail avatarImage" style="max-width: 50px;" src="out/avatar.png" />
	                </div>
	                <div class="row">&nbsp;</div>
	                <div class="row">
                        <img class="img-thumbnail img-circle avatarImage" style="max-width: 150px;" src="out/avatar.png" />
                        <img class="img-thumbnail img-circle avatarImage" style="max-width: 100px;" src="out/avatar.png" />
                        <img class="img-thumbnail img-circle avatarImage" style="max-width: 50px;" src="out/avatar.png" />
	                </div>
                </div>
		    </div>

	    </div>

		<!---<cfset AvGenComponent = createObject("component","AvGen").init().createImage("white","black","test") />--->

	</cfoutput>

    <script>
        //$("form.avatarForm").on("change","input",regenerateImage);
		$("button.doThings").on("click",regenerateImage);

        function regenerateImage() {
            backgroundColor = $("input[name=backgroundColor]").val();
            imageText = $("input[name=imageText]").val();
            textColor = $("input[name=textColor]").val();
            fontFamily = $("select[name=fontFamily] option:selected").text();

            $.ajax( {
                "dataType": 'text',
                "type": 'POST',
                "url": 'AvGen.cfc?method=ajaxGenerateImage',
                "data": {"backgroundColor":backgroundColor,"imageText":imageText,"textColor":textColor,"fontFamily":fontFamily},
                "success": function(e) {
                    //console.log(e);
	                $("img.avatarImage").attr("src","out/"+e);
                    $("a#downloadButton").attr("download",e);
                    $("a#downloadButton").attr("href","out/"+e);
                },
                "timeout": 15000,
                "error": function(e) {
                    console.log('err: ',e);
                }
            });
        }


    </script>

  </body>
</html>