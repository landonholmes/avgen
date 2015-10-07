function downloadImage() {
    this.href = PAGE.avatarCanvasRectLg.toDataURL(); //convers the canvas into an image
    this.download = 'avatar_'+$(PAGE.imageTextInput).val()+'.png'; //sets the download
}

function generateImage() {
    var avatarProps = { //grabbing the values of hte inputs
        backgroundColor: $(PAGE.backgroundColorInput).val()
        ,imageText: $(PAGE.imageTextInput).val()
        ,textColor: $(PAGE.textColorInput).val()
        ,fontFamily: $(PAGE.fontFamilyInput).find(":selected").text()
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

    //this loop checks to see if the font size is too large and reduces it to fit the canvas better
    do {
        avatarProperties.fontSize--;
        context.font = ""+avatarProperties.fontSize+"px "+avatarProperties.fontFamily;
    }while(context.measureText(avatarProperties.imageText).width>canvas.width/2); //TODO: this definitely needs adjusting or to be smarter

    context.textAlign = "center";
    context.fillStyle = "#"+avatarProperties.textColor;
    context.fillText(avatarProperties.imageText, canvasCssWidth / 2, canvasCssHeight / 1.5); //write in the canvas, TODO: the height needs to be smarter
}


