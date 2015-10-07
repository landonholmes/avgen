
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
                            <label class="control-label col-md-6" for="font">Font Family</label>
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
                                <a type="button" class="btn btn-md btn-info" id="downloadButton"><i class="glyphicon glyphicon-download-alt"></i></a>
							</div>
						</div>
					</form>
			    </div>
                <div class="col-md-8">
	                <div class="row">
                        <canvas id="avatarCanvasRectLg" class="img-thumbnail" width="150" height="150"></canvas>
                        <canvas id="avatarCanvasRectMd" class="img-thumbnail" width="100" height="100"></canvas>
                        <canvas id="avatarCanvasRectSm" class="img-thumbnail" width="50" height="50"></canvas>
	                </div>
	                <!---<div class="row">
                        <canvas id="avatarCanvasCirLg" class="img-thumbnail img-circle" width="150" height="150"></canvas>
                        <canvas id="avatarCanvasCirMd" class="img-thumbnail img-circle" width="100" height="100"></canvas>
                        <canvas id="avatarCanvasCirSm" class="img-thumbnail img-circle" width="50" height="50"></canvas>
	                </div>--->
                </div>
		    </div>
	    </div>

	</cfoutput>

	<script src="AvGen.js"></script>
    <script>
		$("button.doThings").on("click",generateImage);
		$("a#downloadButton").on("click",downloadImage);

		$(document).ready(function(){ setTimeout(generateImage,500); }); //to display a default image (timeout is because there's a lag for the canvas or something, idk)

		//some variables used in the .js
        var PAGE = {
            backgroundColorInput: $("input[name=backgroundColor]")
            ,imageTextInput: $("input[name=imageText]")
            ,textColorInput: $("input[name=textColor]")
            ,fontFamilyInput: $("select[name=fontFamily] option:selected")
	        ,avatarImg: $("img.avatarImage")
	        ,avatarDownloadButton: $("a#downloadButton")
	        ,avatarCanvasRectLg: $("canvas#avatarCanvasRectLg")[0]
	        ,avatarCanvasRectMd: $("canvas#avatarCanvasRectMd")[0]
	        ,avatarCanvasRectSm: $("canvas#avatarCanvasRectSm")[0]
	        ,avatarCanvasCirLg: $("canvas#avatarCanvasCirLg")[0]
	        ,avatarCanvasCirMd: $("canvas#avatarCanvasCirMd")[0]
	        ,avatarCanvasCirSm: $("canvas#avatarCanvasCirSm")[0]
        };
    </script>

  </body>
</html>