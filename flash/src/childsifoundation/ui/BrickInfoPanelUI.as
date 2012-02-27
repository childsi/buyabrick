package childsifoundation.ui
{
	import childsifoundation.assets.BrickInfoAsset;
	import childsifoundation.vo.BrickVO;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class BrickInfoPanelUI extends Sprite
	{
		private var info : BrickInfoAsset;
		private var share : ShareOverlay;
		private var link : LinkOverlay;
		private var vo : BrickVO;
		//		
		public function BrickInfoPanelUI()
		{
			super();
			//
			createChildren();
		}
		public function show( vo:BrickVO, isThanks:Boolean = false, thanksMessage : String = "") : void
		{
			this.vo = vo;
			//
			this.share.hide();
			this.link.hide();
			//
			TextField(this.info.getChildByName("titleText")).text = this.vo.displayName;
			//
			if(!isThanks){
				TextField(this.info.getChildByName("bodyText")).text = this.vo.message;
			} else {
				TextField(this.info.getChildByName("bodyText")).text = thanksMessage;
			}
			if( this.vo.value != 0 ) {
				TextField(this.info.getChildByName("describeText")).htmlText = "has donated <font color='#cf6517'>£" + this.vo.value + "</font> to the wall";				
			} else {
				TextField(this.info.getChildByName("describeText")).htmlText = "has donated to the wall";								
			}
			//
			MovieClip(this.info.getChildByName("icon")).gotoAndStop(vo.iconId);
		}

		public function hide() : void
		{
			
		}
		//
		public function _showSharePanel() : void
		{
			this.share.show()();
		}
		protected function createChildren ( ) : void 
		{
			if ( this.info == null ) {
				this.info = new BrickInfoAsset ( ) ;
				//
				MovieClip(this.info.getChildByName("bgClip")).mouseEnabled = false;
				MovieClip(this.info.getChildByName("bgClip")).mouseChildren = false;
				MovieClip(this.info.getChildByName("bgClip")).buttonMode = false;
				//
				/*MovieClip(this.info.getChildByName("shareClip")).mouseEnabled = true;
				MovieClip(this.info.getChildByName("shareClip")).mouseChildren = true;
				MovieClip(this.info.getChildByName("shareClip")).buttonMode = true;
				//
				MovieClip(this.info.getChildByName("shareClip")).addEventListener( MouseEvent.MOUSE_OVER, _handleMouseOver );
				MovieClip(this.info.getChildByName("shareClip")).addEventListener( MouseEvent.MOUSE_OUT, _handleMouseOut );
				MovieClip(this.info.getChildByName("shareClip")).addEventListener( MouseEvent.CLICK, _handleShareClick );
				//*/
				MovieClip(this.info.getChildByName("linkClip")).mouseEnabled = true;
				MovieClip(this.info.getChildByName("linkClip")).mouseChildren = true;
				MovieClip(this.info.getChildByName("linkClip")).buttonMode = true;
				//
				MovieClip(this.info.getChildByName("linkClip")).addEventListener( MouseEvent.MOUSE_OVER, _handleMouseOver );
				MovieClip(this.info.getChildByName("linkClip")).addEventListener( MouseEvent.MOUSE_OUT, _handleMouseOut );
				MovieClip(this.info.getChildByName("linkClip")).addEventListener( MouseEvent.CLICK, _handleLinkClick );				
				//
				this.addChild ( this.info );
			}
			if ( this.share == null ) {
				this.share = new ShareOverlay ( ) ;
				this.addChild ( this.share );
			}
			if ( this.link == null ) {
				this.link = new LinkOverlay () ;
				this.link.x = this.link.y = 10;
				this.addChild ( this.link );
			}						
		}
		private function _handleShareClick( e:MouseEvent ) : void
		{
			this.share.show();
		}
		private function _handleLinkClick( e:MouseEvent ) : void
		{
			this.link.show( this.vo );
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