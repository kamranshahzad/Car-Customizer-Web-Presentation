package com.parts{

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import fl.transitions.*;
	import fl.transitions.easing.*;

	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import flash.display.Shape;
	import com.senocular.transformtoolkit.TransformTool;

	import com.adobe.serialization.json.JSON;
	
	import flash.geom.Matrix;
	
	import gs.TweenLite;
	import gs.OverwriteManager;
	import gs.easing.Circ;
	import com.msgwin.*;
	import com.main.*;
	

	public class Parts extends MovieClip {
		
		// common
		private var Container:MovieClip;
		public var win:MsgWin;
		private var assetPath:String= '';		
		private var initPosX:Number=20;
		private var initPosY:Number=20;
		
		// transform
		public var defaultTool:TransformTool;
		public var customTool:TransformTool;
		public var currTool:TransformTool;
		
		
		//Front Canves View
		public var frontMCArr:Array;    
		private var frontMC:CanvesViewMC;   
		var frontLoader:Loader;
		private var frontPt:Number=0;
		public  var frontImgSrc:String="_blank";
		public var frontActive:Boolean = false;
		
		//Rear View
		public var rearMCArr:Array;		
		private var rearMC:CanvesViewMC;
		var rearLoader:Loader;
		private var rearPt:Number=0;
		public var rearImgSrc:String="_blank";
		public var rearActive:Boolean = false;
		
		//Interior View
		public var interiorMCArr:Array;
		private var interiorMC:CanvesViewMC;
		var interiorLoader:Loader;
		private var interiorPt:Number=0;
		public var interiorImgSrc:String="_blank";
		public var interiorActive:Boolean = false;
		
		//Other View
		public var otherMCArr:Array;
		private var otherMC:CanvesViewMC;
		var otherLoader:Loader;
		private var otherPt:Number=0;
		public var otherImgSrc:String="_blank";
		public var otherActive:Boolean = false;
		
		
		
		//FVIEW View  	(front view)
		public var FVIEWMCArr:Array;
		private var FVIEWMC:SmallFVIEWMC;
		var FVIEWLoader:Loader;
		private var FVIEWPt:Number=0;
		public var FVIEWImgSrc:String="_blank";
		public var FVIEWActive:Boolean = false;
		
		
		//RVIEW View	(rear view)
		public var RVIEWMCArr:Array;
		private var RVIEWMC:SmallRVIEWMC;
		var RVIEWLoader:Loader;
		private var RVIEWPt:Number=0;
		public var RVIEWImgSrc:String="_blank";
		public var RVIEWActive:Boolean = false;
		
		//IVIEW View	(interior view)
		public var IVIEWMCArr:Array;
		private var IVIEWMC:SmallIVIEWMC;
		var IVIEWLoader:Loader;
		private var IVIEWPt:Number=0;
		public var IVIEWImgSrc:String="_blank";
		public var IVIEWActive:Boolean = false;
		

		
		public function Parts():void {// Contructor
			Container = new MovieClip();
			addChild(Container);
			
			
			frontMCArr = new Array();
			rearMCArr = new Array();
			interiorMCArr = new Array();
			otherMCArr = new Array();
			
			FVIEWMCArr = new Array();
			RVIEWMCArr = new Array();
			IVIEWMCArr = new Array();
			
			assetPath = Main.hostDomain + "assets/parts/effected-imgs/";
			
			defaultTool = new TransformTool();
			addChild(defaultTool);
			customTool= new TransformTool();
			addChild(customTool);
			customTool.addControl(new CustomRotationControl());
			customTool.addControl(new CustomResetControl());
			currTool=defaultTool;

			Container.addEventListener(MouseEvent.MOUSE_DOWN, select);
		}

		function select(event) {
			if (event.target is CanvesViewMC) {
				currTool.target = event.target as CanvesViewMC;
			}
			if (event.target is SmallFVIEWMC) {
				currTool.target=event.target as SmallFVIEWMC;
			}
			if (event.target is SmallRVIEWMC) {
				currTool.target=event.target as SmallRVIEWMC;
			}
			if (event.target is SmallIVIEWMC) {
				currTool.target=event.target as SmallIVIEWMC;
			}
		}

		
		/*
			******************************************
			Front Canves View (method)
		*/
		
		function loadFront(url:String):void {
			frontLoader = new Loader();
			frontLoader.load(new URLRequest(url));
			frontLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, frontLoaded);
		}
		public function frontLoaded(event:Event):void {
			var thumbContent:DisplayObject=event.target.content;
			frontMCArr[frontPt-1].addChild(thumbContent);
		}
		public function startFrontClips( imgName:String , VIEW_CONTROL_VAR:String = 'FVIEW') {
			
			frontActive = true;
			
			this.frontImgSrc = imgName;
			var imgURL:String = assetPath + frontImgSrc;
			frontMC = new CanvesViewMC();
			frontMC.name = String(frontPt);
			Container.addChild(frontMC);
			frontMCArr.push(frontMC);
			frontMC.x = initPosX;
			frontMC.y = initPosY;
			initPosX = initPosX + 10;
			loadFront(imgURL);
			frontPt++;
		}
		public function removeFront():void {
			if (MovieClip(currTool.target)==null) {
				//setMessageWin();
			} else {
				Container.removeChild(frontMCArr[Number(currTool.target.name)]);
				delete frontMCArr[Number(currTool.target.name)];
				currTool.target=null;
			}
		}
		
		public function resetFront():void{
			frontMCArr = new Array();
			frontPt = 0;
			frontActive = false;
		}
		
		public function trackFrontCoordinates():String{
			var coordinates:Array = new Array();
			var jsonStr:String = '';
			if(frontMCArr.length > 0){
				for(var p:Number = 0; p < frontMCArr.length; p++){
					var obj:Object = new Object();
					if (frontMCArr[p]!=undefined) {
						obj.dimentions = frontMCArr[p].transform.matrix;
						coordinates.push(obj);
					}
				}
				jsonStr = JSON.encode(coordinates);
			}else{
				jsonStr = "_blank";
			}
			return jsonStr;
		}
		
		
		
		
		/*
			******************************************
			Rear Canves View (method)
		*/
		function loadRear(url:String):void {
			rearLoader = new Loader();
			rearLoader.load(new URLRequest(url));
			rearLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, rearLoaded);
		}
		public function rearLoaded(event:Event):void {
			var thumbContent:DisplayObject=event.target.content;
			rearMCArr[rearPt-1].addChild(thumbContent);
		}
		public function startRearClips( imgName:String , VIEW_CONTROL_VAR:String = 'FVIEW') {
		
			rearActive = true;
			
			this.rearImgSrc = imgName;
			var imgURL:String = assetPath + rearImgSrc;
			rearMC = new CanvesViewMC();
			rearMC.name = String(rearPt);
			Container.addChild(rearMC);
			rearMCArr.push(rearMC);
			rearMC.x = initPosX;
			rearMC.y = initPosY;
			initPosX = initPosX + 10;
			loadRear(imgURL);
			rearPt++;
		}
		public function removeRear():void {
			if (MovieClip(currTool.target)==null) {
				//setMessageWin();
			} else {
				Container.removeChild(rearMCArr[Number(currTool.target.name)]);
				delete rearMCArr[Number(currTool.target.name)];
				currTool.target=null;
			}
		}
		public function resetRear():void{
			rearMCArr = new Array();
			rearPt = 0;
			rearActive = false;
		}
		public function trackRearCoordinates():String{
			var coordinates:Array = new Array();
			var jsonStr:String = '';
			if(rearMCArr.length > 0){
				for(var p:Number = 0; p < rearMCArr.length; p++){
					var obj:Object = new Object();
					if (rearMCArr[p]!=undefined) {
						obj.dimentions = rearMCArr[p].transform.matrix;
						coordinates.push(obj);
					}
				}
				jsonStr = JSON.encode(coordinates);
			}else{
				jsonStr = "_blank";
			}
			return jsonStr;
		}
		
		/*
			******************************************
			Interior Canves View (method)
		*/
		function loadInterior(url:String):void {
			interiorLoader = new Loader();
			interiorLoader.load(new URLRequest(url));
			interiorLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, interiorLoaded);
		}

		public function interiorLoaded(event:Event):void {
			var thumbContent:DisplayObject=event.target.content;
			interiorMCArr[interiorPt-1].addChild(thumbContent);
		}

		public function startInteriorClips( imgName:String , VIEW_CONTROL_VAR:String = 'FVIEW') {
			
			interiorActive = true;
			
			this.interiorImgSrc = imgName;
			var imgURL:String = assetPath + interiorImgSrc;
			interiorMC = new CanvesViewMC();
			interiorMC.name = String(interiorPt);
			Container.addChild(interiorMC);
			interiorMCArr.push(interiorMC);
			interiorMC.x = initPosX;
			interiorMC.y = initPosY;
			initPosX = initPosX + 10;
			loadInterior(imgURL);
			interiorPt++;
		}
		
		public function removeInterior():void {
			if (MovieClip(currTool.target)==null) {
				//setMessageWin();
			} else {
				Container.removeChild(interiorMCArr[Number(currTool.target.name)]);
				delete interiorMCArr[Number(currTool.target.name)];
				currTool.target=null;
			}
		}
		public function resetInterior():void{
			interiorMCArr  = new Array();
			interiorPt     = 0;
			interiorActive = false;
		}
		
		public function trackInteriorCoordinates():String{
			var coordinates:Array = new Array();
			var jsonStr:String = '';
			if(interiorMCArr.length > 0){
				for(var p:Number = 0; p < interiorMCArr.length; p++){
					var obj:Object = new Object();
					if (interiorMCArr[p]!=undefined) {
						obj.dimentions =interiorMCArr[p].transform.matrix;
						coordinates.push(obj);
					}
				}
				jsonStr = JSON.encode(coordinates);
			}else{
				jsonStr = "_blank";
			}
			return jsonStr;
		}
		
		/*
			******************************************
			Other Canves View (method)
		*/
		function loadOther(url:String):void {
			interiorLoader = new Loader();
			interiorLoader.load(new URLRequest(url));
			interiorLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, otherLoaded);
		}

		public function otherLoaded(event:Event):void {
			var thumbContent:DisplayObject=event.target.content;
			otherMCArr[otherPt-1].addChild(thumbContent);
		}

		public function startOtherClips( imgName:String , VIEW_CONTROL_VAR:String = 'FVIEW') {
			
			otherActive = true;
			
			this.otherImgSrc = imgName;
			var imgURL:String = assetPath + otherImgSrc;
			otherMC = new CanvesViewMC();
			otherMC.name = String(otherPt);
			Container.addChild(otherMC);
			otherMCArr.push(otherMC);
			otherMC.x = initPosX;
			otherMC.y = initPosY;
			initPosX = initPosX + 10;
			loadOther(imgURL);
			otherPt++;
		}
		public function removeOther():void {
			if (MovieClip(currTool.target)==null) {
				//setMessageWin();
			} else {
				Container.removeChild(otherMCArr[Number(currTool.target.name)]);
				delete otherMCArr[Number(currTool.target.name)];
				currTool.target=null;
			}
		}
		public function resetOther():void{
			otherMCArr  = new Array();
			otherPt     = 0;
			otherActive = false;
		}
		public function trackOtherCoordinates():String{
			var coordinates:Array = new Array();
			var jsonStr:String = '';
			if(otherMCArr.length > 0){
				for(var p:Number = 0; p < otherMCArr.length; p++){
					var obj:Object = new Object();
					if (otherMCArr[p]!=undefined) {
						obj.dimentions = otherMCArr[p].transform.matrix;
						coordinates.push(obj);
					}
				}
				jsonStr = JSON.encode(coordinates);
			}else{
				jsonStr = "_blank";
			}
			return jsonStr;
		}
		
		
		/*
			******************************************
			FVIEW Small View 
		*/
		function loadFVIEW(url:String):void {
			FVIEWLoader = new Loader();
			FVIEWLoader.load(new URLRequest(url));
			FVIEWLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, FVIEWLoaded);
		}

		public function FVIEWLoaded(event:Event):void {
			var thumbContent:DisplayObject=event.target.content;
			FVIEWMCArr[FVIEWPt-1].addChild(thumbContent);
		}

		public function startFVIEWClips( imgName:String ) {
			
			FVIEWActive = true;
			
			this.FVIEWImgSrc = imgName;
			var imgURL:String = assetPath + FVIEWImgSrc;
			FVIEWMC = new SmallFVIEWMC();
			FVIEWMC.name = String(FVIEWPt);
			Container.addChild(FVIEWMC);
			FVIEWMCArr.push(FVIEWMC);
			FVIEWMC.x = initPosX;
			FVIEWMC.y = initPosY;
			initPosX = initPosX + 10;
			loadFVIEW(imgURL);
			FVIEWPt++;
		}
		
		public function removeFVIEW():void {
			if (MovieClip(currTool.target)==null) {
				//setMessageWin();
			} else {
				Container.removeChild(FVIEWMCArr[Number(currTool.target.name)]);
				delete FVIEWMCArr[Number(currTool.target.name)];
				currTool.target=null;
			}
		}
		public function resetFVIEW():void{
			FVIEWMCArr  = new Array();
			FVIEWPt     = 0;
			FVIEWActive = false;
		}
		
		public function trackFVIEWoordinates():String{
			var coordinates:Array = new Array();
			var jsonStr:String = '';
			if(FVIEWMCArr.length > 0){
				for(var p:Number = 0; p < FVIEWMCArr.length; p++){
					var obj:Object = new Object();
					if (FVIEWMCArr[p]!=undefined) {
						obj.dimentions = FVIEWMCArr[p].transform.matrix;
						coordinates.push(obj);
					}
				}
				jsonStr = JSON.encode(coordinates);
			}else{
				jsonStr = "_blank";
			}
			return jsonStr;
		}
		
		/*
			******************************************
			RVIEW Small View 
		*/
		function loadRVIEW(url:String):void {
			RVIEWLoader = new Loader();
			RVIEWLoader.load(new URLRequest(url));
			RVIEWLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, RVIEWLoaded);
		}

		public function RVIEWLoaded(event:Event):void {
			var thumbContent:DisplayObject=event.target.content;
			RVIEWMCArr[RVIEWPt-1].addChild(thumbContent);
		}

		public function startRVIEWClips( imgName:String ) {
			
			RVIEWActive = true;
			
			this.RVIEWImgSrc = imgName;
			var imgURL:String = assetPath + RVIEWImgSrc;
			RVIEWMC = new SmallRVIEWMC();
			RVIEWMC.name = String(RVIEWPt);
			Container.addChild(RVIEWMC);
			RVIEWMCArr.push(RVIEWMC);
			RVIEWMC.x = initPosX;
			RVIEWMC.y = initPosY;
			initPosX = initPosX + 10;
			loadRVIEW(imgURL);
			RVIEWPt++;
		}
		public function removeRVIEW():void {
			if (MovieClip(currTool.target)==null) {
				//setMessageWin();
			} else {
				Container.removeChild(RVIEWMCArr[Number(currTool.target.name)]);
				delete RVIEWMCArr[Number(currTool.target.name)];
				currTool.target=null;
			}
		}
		public function resetRVIEW():void{
			RVIEWMCArr = new Array();
			RVIEWPt    = 0;
			RVIEWActive= false;
		}
		
		public function trackRVIEWoordinates():String{
			var coordinates:Array = new Array();
			var jsonStr:String = '';
			if(RVIEWMCArr.length > 0){
				for(var p:Number = 0; p < RVIEWMCArr.length; p++){
					var obj:Object = new Object();
					if (RVIEWMCArr[p]!=undefined) {
						obj.dimentions = RVIEWMCArr[p].transform.matrix;
						coordinates.push(obj);
					}
				}
				jsonStr = JSON.encode(coordinates);
			}else{
				jsonStr = "_blank";
			}
			return jsonStr;
		}
		
		/*
			******************************************
			IVIEW Small View 
		*/
		function loadIVIEW(url:String):void {
			IVIEWLoader = new Loader();
			IVIEWLoader.load(new URLRequest(url));
			IVIEWLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, IVIEWLoaded);
		}

		public function IVIEWLoaded(event:Event):void {
			var thumbContent:DisplayObject=event.target.content;
			IVIEWMCArr[IVIEWPt-1].addChild(thumbContent);
		}

		public function startIVIEWClips( imgName:String ) {
			
			IVIEWActive = true;
			
			this.IVIEWImgSrc = imgName;
			var imgURL:String = assetPath + IVIEWImgSrc;
			IVIEWMC = new SmallIVIEWMC();
			IVIEWMC.name = String(IVIEWPt);
			Container.addChild(IVIEWMC);
			IVIEWMCArr.push(IVIEWMC);
			IVIEWMC.x = initPosX;
			IVIEWMC.y = initPosY;
			initPosX = initPosX + 10;
			loadIVIEW(imgURL);
			IVIEWPt++;
		}
		
		public function removeIVIEW():void {
			if (MovieClip(currTool.target)==null) {
				//setMessageWin();
			} else {
				Container.removeChild(IVIEWMCArr[Number(currTool.target.name)]);
				delete IVIEWMCArr[Number(currTool.target.name)];
				currTool.target=null;
			}
		}
		public function resetIVIEW():void{
			IVIEWMCArr = new Array();
			IVIEWPt    = 0;
			IVIEWActive= false;
		}
		
		public function trackIVIEWoordinates():String{
			var coordinates:Array = new Array();
			var jsonStr:String = '';
			if(IVIEWMCArr.length > 0){
				for(var p:Number = 0; p < IVIEWMCArr.length; p++){
					var obj:Object = new Object();
					if (IVIEWMCArr[p]!=undefined) {
						obj.dimentions = IVIEWMCArr[p].transform.matrix;
						coordinates.push(obj);
					}
				}
				jsonStr = JSON.encode(coordinates);
			}else{
				jsonStr = "_blank";
			}
			return jsonStr;
		}
		
		
		
		/*
			******************************************************************************
			DATA BASE LAYER
		*/
		public function createNewAccessory($table:String,$vehicle_id:Number,$wheel_category_id:Number,$part_category_id:Number, $effected:Number,$part_name:String,$part_manufacturer:String,$description:String,$sku:String,$status:Number,$part_icon:String,$part_price:Number=0 ,$montly_price:Number = 0):void{
			var myService = new NetConnection();
			myService.connect(Main.gateWay);
			var responder=new Responder(get_part_id,onFault);
			if($table == 'w'){
				myService.call("AddOnCars.insertWheels", responder , $vehicle_id , $wheel_category_id ,$effected, $part_name, $part_manufacturer,$description,$sku,$status,$part_icon,$part_price, $montly_price, frontImgSrc , rearImgSrc , interiorImgSrc, otherImgSrc , FVIEWImgSrc , RVIEWImgSrc , IVIEWImgSrc , trackFrontCoordinates() , trackRearCoordinates(), trackInteriorCoordinates(), trackOtherCoordinates(), trackFVIEWoordinates(), trackRVIEWoordinates(), trackIVIEWoordinates() );
			}else{
				myService.call("AddOnCars.insertParts", responder , $vehicle_id , $part_category_id ,$effected, $part_name, $part_manufacturer,$description,$sku,$status,$part_icon,$part_price, $montly_price , frontImgSrc , rearImgSrc , interiorImgSrc, otherImgSrc , FVIEWImgSrc , RVIEWImgSrc , IVIEWImgSrc , trackFrontCoordinates() , trackRearCoordinates(), trackInteriorCoordinates(), trackOtherCoordinates(), trackFVIEWoordinates(), trackRVIEWoordinates(), trackIVIEWoordinates() );
			}
		}
		
		
		public function get_part_id(rs:Object) {
			//trace("part id: "+ rs);
		}
		

		/*
		**********************************************************************************
		Helpers
		*/
		
		public function updateApplication( viewControlVar:String ):void {
			switch(viewControlVar){
				case 'FVIEW':
						showParts(frontMCArr);
						hideParts(rearMCArr);
						hideParts(interiorMCArr);
						hideParts(otherMCArr);
						break;
				case 'RVIEW':
						showParts(rearMCArr);
						hideParts(frontMCArr);
						hideParts(interiorMCArr);
						hideParts(otherMCArr);
						break;
				case 'IVIEW':
						showParts(interiorMCArr);
						hideParts(frontMCArr);
						hideParts(rearMCArr);
						hideParts(otherMCArr);
						break;
				case 'OVIEW':
						showParts(otherMCArr);
						hideParts(frontMCArr);
						hideParts(rearMCArr);
						hideParts(interiorMCArr);
						break;
			}
		}
		
		public function showParts(MCArray:Array):void{
			if(MCArray.length > 0){
				for(var i:Number = 0; i < MCArray.length; i++){
					if(MCArray[i] != undefined){
						MCArray[i].visible = true;
					}
				}
			}
		}
		
		public function hideParts(MCArray:Array):void{
			if(MCArray.length > 0){
				for(var i:Number = 0; i < MCArray.length; i++){
					if(MCArray[i] != undefined){
						MCArray[i].visible = false;
					}
				}
			}
		}
		
		
		/*
			**********************************************************************************************
			Message Window
		*/
		
		/*
		public function setMessageWin():void{
			if(!win){
					var $msgStr = "Please select vehicle accessory to remove!";
					win = new MsgWin("Information", $msgStr , "  OK  ");
					win.addEventListener("winCompleteEvent", removePartResponse);
					initMsgWindow();
			}
		}
		public function initMsgWindow():void{
			if(win){
				Container.addChild(win);
				win.x = 540;
				win.y = 290;
				TweenLite.from(win, 1, {alpha:0  });
				TweenLite.to(win, 1, {alpha:1});
			}
		}
		
		
		public function removePartResponse(e:WinCompleteEvent):void {
			if(win){
				Container.removeChild(win);
				win = null;
			}
		}
		*/
		
		

		/* Remnoting  */
		public function onFault(f:Event ) {
			trace("There was a problem");
		}
		
		

		public function Debug($ERROR):void {
			trace("ERROR:"+$ERROR);
		}

	}//$class
}//$package