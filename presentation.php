<html>
<head>
<title> .: Deals Presentation : AddonCars :.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
	body {
		font-family: Tahoma, Arial;
		font-weight: normal;
		font-size: 11px;
		text-decoration: none;
		margin: 0px;
		padding: 0px;
	}
	.clear{ clear:both;}
	.maincontainer01 {
		background-image: url(deal-page.jpg);
		background-repeat: no-repeat;
		background-position: center top;
	}
	.center { margin-left:auto; margin-right:auto;}
	.flashUI{
	    width:1200px;
		height:800px;
		padding-top:56px;
	}
</style>

<script type="text/javascript" src="swfobject/swfobject.js"></script>
</head>
<body>
	<div class="maincontainer01 center">
    	<div class="flashUI center">
        <div id="flashMovie"></div>
			<script type="text/javascript">
				// <![CDATA[
				var so = new SWFObject("index.swf", "flashMovie", "1200", "800", "8", "#FFFFFF");
				so.addParam("scale", "false");
				so.addParam("allowscriptaccess", "exactFit");
				so.addVariable("dealType", "payment");
				so.addVariable("vehicleID", "1");
				so.addVariable("userID", "1");
				so.addVariable("dealRef", "324");
				so.addVariable("dealWork", "create");
				so.write("flashMovie");
				// ]]>
            </script>
        </div>
    </div>
</body>
</html>