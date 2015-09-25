component name="AvGen" accessors="true" {
	property Numeric imageHeight;
	property Numeric imageWidth;
	property String imageName;

	public any function init(
			Numeric imageHeight = 322
			,Numeric imageWidth  = 322
			,String imageName = ("avatar_" & _dateTimeFormat(now()))
			) {
				setImageHeight(arguments.imageHeight);
				setImageWidth(arguments.imageWidth);
				setImageName(arguments.imageName);

				return this;
	}

	public any function createImage(String backgroundColor, String textColor, String imageText) returnformat="plain"{
		local.avatar = imageNew("",imageHeight,imageWidth,'',arguments.backgroundColor);
		imageSetDrawingColor(local.avatar,arguments.textColor);

		imageSetAntialiasing(local.avatar,'on');
		textAttr = {
			'font'='Arial'
			,'size'=150
		};

		local.textDimensions = GetTextDimensions(imageText,textAttr);

		local.x=max(imageWidth,imageHeight);
		local.tempTextHeight=imageHeight*local.textDimensions.height/local.x;
		local.tempTextWidth=imageWidth*local.textDimensions.width/local.x;

		local.calculatedCenterX = (imageWidth/2 - local.tempTextWidth/2);
		local.calculatedCenterY = (imageHeight/2 + local.tempTextHeight/3.65);

		imageDrawText(local.avatar,#arguments.imageText#,calculatedCenterX,calculatedCenterY,textAttr);

		imageWrite(local.avatar,"#expandPath('out')#/#imageName#.png",true);

		return "#imageName#.png";
	}

	remote String function ajaxGenerateImage() returnformat="plain" {
		init(imageName=("avatar_" & arguments.imageText & "_" & _dateTimeFormat(now())));

		return createImage(arguments.backgroundColor,arguments.textColor,arguments.imageText);
	}

	public String function _dateTimeFormat(any ts) {
		return "" & dateformat(ts,"YYYYDDMM") & timeformat(ts,"_HHmmss");
	}


	//I shamelessly stole this from Ben Nadel: http://www.bennadel.com/blog/1150-gettextdimensions-for-finding-coldfusion-image-text-dimensions.htm
	public struct function GetTextDimensions(required String text, required struct FontProperties){
	/*hint="Give the string and the font properties, the width and height of the text is calculated. If the font properties struct is missing any values, ColdFusion's default values will be used.">*/

		local.Image = ImageNew( "", 1, 1, "rgb" );


		local.Graphics = ImageGetBufferedImage(local.Image).GetGraphics();

		local.CurrentFont = local.Graphics.GetFont();


		if (NOT StructKeyExists( arguments.FontProperties, "Size" )) {
			arguments.FontProperties.Size = local.CurrentFont.GetSize();
		}


		if (NOT StructKeyExists( arguments.FontProperties, "Font" )) {
			arguments.FontProperties.Font = local.CurrentFont.GetFontName();
		}


		if (NOT StructKeyExists( arguments.FontProperties, "Style" )) {
			if ( local.CurrentFont.IsBold() AND local.CurrentFont.IsItalic() ) {
				arguments.FontProperties.Style = "bolditalic";
				local.FontStyleMask = BitOR(local.CurrentFont.BOLD, local.CurrentFont.ITALIC);
			} else if (local.CurrentFont.IsBold()) {
				arguments.FontProperties.Style = "bold";
				local.FontStyleMask = local.CurrentFont.BOLD;
			} else if (local.CurrentFont.IsItalic()) {
				arguments.FontProperties.Style = "italic";
				local.FontStyleMask = local.CurrentFont.ITALIC;
			} else {
				arguments.FontProperties.Style = "plain";
				local.FontStyleMask = local.CurrentFont.PLAIN;
			}
		} else {
			local.FontStyleMask = local.CurrentFont.PLAIN;
		}


		local.NewFont = CreateObject("java", "java.awt.Font").Init(
			JavaCast( "string", arguments.FontProperties.Font ),
			JavaCast( "int", local.FontStyleMask ),
			JavaCast( "int", arguments.FontProperties.Size )
				);

		local.FontMetrics = local.Graphics.GetFontMetrics(local.NewFont);

		local.TextBounds = local.FontMetrics.GetStringBounds(
			JavaCast( "string", arguments.Text ),
			local.Graphics
				);


		local.returnStruct = {
			Width = Ceiling( local.TextBounds.GetWidth() ),
			Height = Ceiling( local.TextBounds.GetHeight() )
		};

		return local.returnStruct;
	}
}
