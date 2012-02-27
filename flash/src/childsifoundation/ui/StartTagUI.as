package childsifoundation.ui
{
	import childsifoundation.assets.StartAsset;
	import childsifoundation.model.ChildsFoundationModel;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.core.UIComponent;

	public class StartTagUI extends UIComponent
	{
		private var model : ChildsFoundationModel;
		//
		private var tag : StartAsset;
		//
		public function StartTagUI()
		{
			super();
			//
			model = ChildsFoundationModel.getInstance();
		}
		override protected function createChildren ( ) : void 
		{
			if ( this.tag == null ) {
				this.tag = new StartAsset ( ) ;
				//
				MovieClip(this.tag.getChildByName("bgClip")).buttonMode = false;
				MovieClip(this.tag.getChildByName("bgClip")).mouseEnabled = false;
				MovieClip(this.tag.getChildByName("bgClip")).mouseChildren = false;
				//
				MovieClip(this.tag.getChildByName("buyClip")).buttonMode = true;
				MovieClip(this.tag.getChildByName("buyClip")).mouseEnabled = true;
				MovieClip(this.tag.getChildByName("buyClip")).mouseChildren = false;
				MovieClip(this.tag.getChildByName("buyClip")).addEventListener( MouseEvent.MOUSE_OVER, _handleMouseOver );
				MovieClip(this.tag.getChildByName("buyClip")).addEventListener( MouseEvent.MOUSE_OUT, _handleMouseOut );
				MovieClip(this.tag.getChildByName("buyClip")).addEventListener( MouseEvent.CLICK, _handleBuyClick );		
				//
				MovieClip(this.tag.getChildByName("closeClip")).buttonMode = true;
				MovieClip(this.tag.getChildByName("closeClip")).mouseEnabled = true;
				MovieClip(this.tag.getChildByName("closeClip")).mouseChildren = false;
				MovieClip(this.tag.getChildByName("closeClip")).addEventListener( MouseEvent.MOUSE_OVER, _handleMouseOver );
				MovieClip(this.tag.getChildByName("closeClip")).addEventListener( MouseEvent.MOUSE_OUT, _handleMouseOut );
				MovieClip(this.tag.getChildByName("closeClip")).addEventListener( MouseEvent.CLICK, _handleCloseClick );	
				
				MovieClip(this.tag.getChildByName("findOut")).buttonMode = true;	
				MovieClip(this.tag.getChildByName("findOut")).mouseEnabled = true;
				MovieClip(this.tag.getChildByName("findOut")).mouseChildren = false;
				MovieClip(this.tag.getChildByName("findOut")).addEventListener( MouseEvent.MOUSE_OVER, _handleMouseOver );
				MovieClip(this.tag.getChildByName("findOut")).addEventListener( MouseEvent.MOUSE_OUT, _handleMouseOut );
				MovieClip(this.tag.getChildByName("findOut")).addEventListener( MouseEvent.CLICK, _handleFindOutClick );
				//						
				this.addChild ( this.tag ) ;
			}		
		}
		protected function onAddedToStage ( event:Event ) : void {
			this.removeEventListener ( Event.ADDED_TO_STAGE , this.onAddedToStage ) ;
		}
		private function _handleBuyClick( e:MouseEvent ) : void
		{
			e.stopImmediatePropagation();
			e.stopPropagation();
			//
			navigateToURL( new URLRequest(model.applicationParams["donatePath"]), "_self" );
		}
		private function _handleFindOutClick( e:MouseEvent ) : void
		{
			e.stopImmediatePropagation();
			e.stopPropagation();
			//
			navigateToURL( new URLRequest(model.applicationParams["findOutPath"]), "_self" );
		}
		private function _handleCloseClick( e:MouseEvent ) : void
		{
			
		}		
		private function _handleMouseOver( e:MouseEvent ) : void
		{
			MovieClip(e.target).gotoAndStop( "over" );
		}
		private function _handleMouseOut( e:MouseEvent ) : void
		{
			MovieClip(e.target).gotoAndStop( "out" );
		}				
	}
}