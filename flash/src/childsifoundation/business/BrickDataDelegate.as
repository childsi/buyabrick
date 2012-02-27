package childsifoundation.business
{
	import childsifoundation.model.ChildsFoundationModel;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.nonpology.requests.XMLLoader;
	//
	[Event(name="complete", type="flash.events.Event")]
	public class BrickDataDelegate extends EventDispatcher 
	{
		private var _content : XML ;
		//
		public function get content ( ) : XML {
			return this._content ;	
		}
		//
		public function getBricks ( path:String ) : void {
			//var append : String = "?id=" + Math.random ( ) * 1000000 ;
			//var loader : XMLLoader = new XMLLoader ( path + "" + append ) ;
			var loader : XMLLoader = new XMLLoader ( path ) ;
			loader.addEventListener ( Event.COMPLETE , this._onBricksLoad ) ;
			loader.start();
		}
		//
		private function _onBricksLoad ( event:Event ) : void 
		{
			var loader : XMLLoader = ( event.target as XMLLoader ) ;
			loader.removeEventListener ( Event.COMPLETE , this._onBricksLoad ) ;
			loader.dispose();
			this._content = loader.data ;
			this.dispatchEvent ( new Event ( Event.COMPLETE ) ) ;
			//
			ChildsFoundationModel.getInstance().bricks = this._content;
		}
	}
}