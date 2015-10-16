function downloadImage() {
    this.href = PAGE.avatarCanvasRectLg.toDataURL(); //convers the canvas into an image
    this.download = 'avatar_'+$(PAGE.imageTextInput).val()+'.png'; //sets the download
}

function generateImage() {
    var avatarProps = { //grabbing the values of hte inputs
        imageText: $(PAGE.imageTextInput).val()
        ,font: $(PAGE.fontInput).find(":selected").text()
        ,fontWeight: $(PAGE.fontWeightInput).find(":selected").text()
        ,fontStyle: $(PAGE.fontStyleInput).find(":selected").text()
        ,textColor: $(PAGE.textColorInput).val()
        ,backgroundColor: $(PAGE.backgroundColorInput).val()
        ,borderColor: $(PAGE.borderColorInput).val()
        ,borderThickness: $(PAGE.borderThicknessInput).val()
        ,fontSize: 128
    };

    //draw on each canvas size, would've just copied the canvas content but I need to rewrite the text in a differing size each time
    drawAvatarOnACanvas(avatarProps,PAGE.avatarCanvasRectLg);
    drawAvatarOnACanvas(avatarProps,PAGE.avatarCanvasRectMd);
    drawAvatarOnACanvas(avatarProps,PAGE.avatarCanvasRectSm);
    //drawAvatarOnACanvas(avatarProps,PAGE.avatarCanvasCirLg);
    //drawAvatarOnACanvas(avatarProps,PAGE.avatarCanvasCirMd);
    //drawAvatarOnACanvas(avatarProps,PAGE.avatarCanvasCirSm);
}

function drawAvatarOnACanvas(avatarProperties,canvas) {
    var context = canvas.getContext("2d"); //get the context of the canvas we are given

    //need to get the height/width for stuff
    var canvasWidth = $(canvas).attr("width"),
        canvasHeight = $(canvas).attr("height"),
        canvasCssWidth = canvasWidth,
        canvasCssHeight = canvasHeight;

    //check if we need to adjust
    if (window.devicePixelRatio) {
        $(canvas).attr("width", canvasWidth * window.devicePixelRatio);
        $(canvas).attr("height", canvasHeight * window.devicePixelRatio);
        $(canvas).css("width", canvasCssWidth);
        $(canvas).css("height", canvasCssHeight);
        context.scale(window.devicePixelRatio, window.devicePixelRatio);
    }

    //color in the background
    context.fillStyle = "#"+avatarProperties.backgroundColor;
    context.fillRect (0, 0, canvas.width, canvas.height);


    //scale the border for smaller canvases
    var borderRatio = avatarProperties.borderThickness*2/$(PAGE.avatarCanvasRectLg).attr("width");
    avatarProperties.borderThickness = avatarProperties.borderThickness*borderRatio;
    if (avatarProperties.borderThickness < 1 && avatarProperties.borderThickness > 0) {avatarProperties.borderThickness = 1;}

    //draw the border
    context.lineWidth = avatarProperties.borderThickness;
    context.strokeStyle = "#"+avatarProperties.borderColor;
    context.strokeRect(0,0,canvas.width, canvas.height);


    var allText = avatarProperties.imageText.split("\\n");//see if there are any new lines
    //this loop checks to see if the font size is too large and reduces it to fit the canvas better
    do {
        avatarProperties.fontSize--;
        context.font = ""+avatarProperties.fontStyle+" "+avatarProperties.fontWeight+" "+avatarProperties.fontSize+"px "+avatarProperties.font;
    }while(context.measureText(avatarProperties.imageText).width/allText.length>canvas.width*3/4);

    context.textAlign = "center";
    context.fillStyle = "#"+avatarProperties.textColor;

    var x = canvasCssWidth / 2;
    var y = (canvasCssHeight/2+avatarProperties.fontSize/3);

    if (allText.length > 1) {
        for (var i = 0; i < allText.length; i++) {
            context.fillText(allText[i], x, y - (avatarProperties.fontSize / allText.length));
            y += avatarProperties.fontSize * allText.length / 2;
        }
    } else {
        context.fillText(avatarProperties.imageText, x, y); //write in the canvas,
    }
}


