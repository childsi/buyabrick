package childsifoundation.model {
	import org.nonpology.requests.XMLLoader;	
	
	import childsifoundation.vo.ApplicationState;
	import childsifoundation.vo.BrickVO;
	
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	import mx.logging.targets.LineFormattedTarget;
	import mx.logging.targets.TraceTarget;
	
	import org.nonpology.utils.MathX;
	import org.nonpology.model.IModelLocator;

	[Bindable]
	public class ChildsFoundationModel extends EventDispatcher implements IModelLocator 
	{
		private var logger : ILogger;
		private static var instance : ChildsFoundationModel = null;
		//
		public var applicationState : String = ApplicationState.PRELOADING;
		public var applicationParams : Dictionary;
		public var scrollPercentage : Number = 0;
		private var _bricks : XML;
		private var _brickData : ArrayCollection;
		private var _config : XML;
		public var wallScrollingNeeded : Boolean = true;
		public var wallStartPercentage : Number = 0;
		//
		public var brickTextValue : String = "0";
		public var dateTextValue : String = "0";
		public var moneyTextValue : String ="0";
		public var messagesTextValue : String = "0";
		public var countriesTextValue : String = "0";
		public var deepLinked : Boolean = false;
		//
		public function ChildsFoundationModel ( ) {
			if ( instance != null ) this.logger.error ( "Only one Model instance should be instantiated" ) ;
			else this.initLogging ( ) ;
		}
		public static function getInstance ( ) : ChildsFoundationModel {
			if ( instance == null ) { instance = new ChildsFoundationModel() };
			return instance ;
		}
		public function loadConfig( ) : void
		{
			var configPath : String = (applicationParams["config"])? applicationParams["config"] : "http://www.childsifoundation.org/files/buyabrick/xml/config.xml";
			var loader : XMLLoader = new XMLLoader ( configPath ) ;
			loader.addEventListener ( Event.COMPLETE , this._onConfigLoad ) ;
			loader.start();
		}
		//
		private function _onConfigLoad ( event:Event ) : void 
		{
			var loader : XMLLoader = ( event.target as XMLLoader ) ;
			loader.removeEventListener ( Event.COMPLETE , this._onConfigLoad ) ;
			loader.dispose();
			this._config = loader.data ;
			
			if(!applicationParams) applicationParams = new Dictionary();
			
			applicationParams["path"] = _config.paths.bricks;
			applicationParams["donatePath"] = _config.paths.donate;
			applicationParams["findOutPath"] = _config.paths.findOut;
			applicationParams["deepLinkURL"] = _config.paths.deepLinkURL;
				
			applicationParams["brickDefault"] = _config.text.brickDefault;	
			applicationParams["whereMoney"] = _config.text.whereMoney;
			applicationParams["thanksMessage"] = _config.text.thanksMessage;
			
			applicationParams["custom_a"] = _config.bricks.custom_a;
			applicationParams["custom_b"] = _config.bricks.custom_b;
			applicationParams["custom_c"] = _config.bricks.custom_c;
			applicationParams["custom_d"] = _config.bricks.custom_d;
			applicationParams["custom_e"] = _config.bricks.custom_e;
			applicationParams["custom_f"] = _config.bricks.custom_f
			applicationParams["custom_g"] = _config.bricks.custom_g
			applicationParams["custom_h"] = _config.bricks.custom_h
			applicationParams["custom_i"] = _config.bricks.custom_i
			applicationParams["custom_j"] = _config.bricks.custom_j
			applicationParams["custom_k"] = _config.bricks.custom_k;
			applicationParams["custom_l"] = _config.bricks.custom_l;
			
			applicationParams["custom_a_rollover"] = _config.bricks.custom_a.@rollOver;
			applicationParams["custom_b_rollover"] = _config.bricks.custom_b.@rollOver;
			applicationParams["custom_c_rollover"] = _config.bricks.custom_c.@rollOver;
			applicationParams["custom_d_rollover"] = _config.bricks.custom_d.@rollOver;
			applicationParams["custom_e_rollover"] = _config.bricks.custom_e.@rollOver;
			applicationParams["custom_f_rollover"] = _config.bricks.custom_f.@rollOver;
			applicationParams["custom_g_rollover"] = _config.bricks.custom_g.@rollOver;
			applicationParams["custom_h_rollover"] = _config.bricks.custom_h.@rollOver;
			applicationParams["custom_i_rollover"] = _config.bricks.custom_i.@rollOver;
			applicationParams["custom_j_rollover"] = _config.bricks.custom_j.@rollOver;
			applicationParams["custom_k_rollover"] = _config.bricks.custom_k.@rollOver;
			applicationParams["custom_l_rollover"] = _config.bricks.custom_l.@rollOver;
			
			if(applicationParams["brickId"]) deepLinked = true;
		}
		private function initLogging ( ) : void 
		{
			var filters : Array = [ "*" ] ;
			var debug : Boolean = true;
			if ( debug ) {
	 			var traceTarget : LineFormattedTarget = new TraceTarget();
	        	traceTarget.filters = filters;
	        	traceTarget.level = LogEventLevel.ALL;
	        	traceTarget.includeCategory = true;
	 			traceTarget.includeLevel = true;
	 			Log.addTarget ( traceTarget );
 			}
 			//
 			this.logger = Log.getLogger ( "ChildsFoundationModel" ) ;
	     	this.logger.info ( "Model initialized" ) ;
	     	this.logger.info ( "XXX initialized" ) ;
		}
		public function setWallScrollingNeeded( b:Boolean ) : void
		{
			trace("setWallScrollingNeeded() " + b);
			wallScrollingNeeded = b;
		} 
		//
		public function set bricks( d:XML ) : void
		{
			_bricks = d;
			//
			var bricks : XMLList = _bricks..brick;
			var vo : BrickVO;
			var node : XML;
			var brickData : ArrayCollection = new ArrayCollection(); 
			//
			for each( node in bricks ) 
			{
				vo = new BrickVO();
				vo.colour = node["colour"].text();
				vo.firstName = node["first-name"].text();
				vo.lastName = node["last-name"].text();
				vo.displayName = node["display-name"].text();
				vo.iconId = node["icon-id"].text();
				vo.urlKey = node["url-key"].text();
				vo.value = node["value"].text();
				vo.message = (node.message != undefined)? node["message"].text() : applicationParams["brickDefault"];
				vo.brickFrame = returnBrick(node["value"]);
				vo.fullURL = applicationParams["deepLinkURL"] + vo.urlKey;
				//
				brickData.addItem( vo );
			}
			//
			brickTextValue = _bricks.details["total-bricks"].text();
			moneyTextValue = _bricks.details["total-money"].text();
			dateTextValue = _bricks.details["date"].text();
			messagesTextValue = _bricks.details["total-messages"].text();
			countriesTextValue = _bricks.details["total-countries"].text();
			//
			_brickData = brickData;
			//
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		//
		private function returnBrick(value:Number) : int
		{
			for (var i : int = 1; i <= 4; i++) {
				if(value <= applicationParams["brick"+i]) return i;
			}
			return 5;
		}
		public function get bricks() : XML {
			return _bricks;
		}
		public function get brickData ( ) : ArrayCollection {
			return this._brickData ;	
		}			
	}
}