package childsifoundation.ui
{
	import childsifoundation.assets.LinkPanel;
	import childsifoundation.vo.BrickVO;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.text.TextField;
	//
	public class LinkOverlay extends Sprite
	{
		private var info : LinkPanel;
		private var vo : BrickVO;
		//
		public function LinkOverlay()
		{
			super();
			//
			render();
		}
		private function render() : void
		{
			this.visible = false;
			//
			this.graphics.beginFill( 0xFFFFFF, 1 );
			this.graphics.drawRoundRect( 0, 0, 220, 162, 10, 10 );
			this.graphics.endFill();
			//
			if ( this.info == null ) {
				this.info = new LinkPanel();
				//				
				MovieClip(this.info.getChildByName("closeClip")).buttonMode = true;
				MovieClip(this.info.getChildByName("closeClip")).mouseEnabled = true;
				MovieClip(this.info.getChildByName("closeClip")).mouseChildren = false;
				MovieClip(this.info.getChildByName("closeClip")).addEventListener( MouseEvent.MOUSE_OVER, _handleMouseOver );
				MovieClip(this.info.getChildByName("closeClip")).addEventListener( MouseEvent.MOUSE_OUT, _handleMouseOut );
				MovieClip(this.info.getChildByName("closeClip")).addEventListener( MouseEvent.CLICK, _handleCloseClick );	
				//
				this.addChild( this.info ); 
			}			
		}	
		private function _handleCloseClick( e:MouseEvent ) : void
		{
			hide();
		}		
		private function _handleMouseOver( e:MouseEvent ) : void
		{
			MovieClip(e.target).gotoAndStop( "over" );
		}
		private function _handleMouseOut( e:MouseEvent ) : void
		{
			MovieClip(e.target).gotoAndStop( "out" );
		}		
		public function show( v:BrickVO ) : void
		{		
			this.vo = v;
			//
			TextField(this.info.getChildByName("titleText")).text = "Link to this brick";
			if( this.vo.value != 0 ) {
				TextField(this.info.getChildByName("describeText")).htmlText = "<font color='#cf6517'>" + this.vo.displayName + "</font> has donated <font color='#cf6517'>£" + this.vo.value + "</font> to the wall. Copy the link below for a direct link back to this brick.";
			} else {
				TextField(this.info.getChildByName("describeText")).htmlText = "<font color='#cf6517'>" + this.vo.displayName + "</font> has donated to the wall. Copy the link below for a direct link back to this brick.";
			}
			
			TextField(this.info.getChildByName("bodyText")).text = this.vo.fullURL;
			//
			MovieClip(this.info.getChildByName("copylinkClip")).gotoAndStop(1);
			MovieClip(this.info.getChildByName("copylinkClip")).buttonMode = true;
			MovieClip(this.info.getChildByName("copylinkClip")).mouseEnabled = true;
			MovieClip(this.info.getChildByName("copylinkClip")).mouseChildren = false;			
			MovieClip(this.info.getChildByName("copylinkClip")).addEventListener( MouseEvent.MOUSE_OVER, _handleMouseOver );
			MovieClip(this.info.getChildByName("copylinkClip")).addEventListener( MouseEvent.MOUSE_OUT, _handleMouseOut );
			MovieClip(this.info.getChildByName("copylinkClip")).addEventListener( MouseEvent.CLICK, _handleClickURL );								
			//
			this.visible = true;		
		}
		protected function _handleClickURL( e:MouseEvent ) : void
		{
			System.setClipboard( this.vo.fullURL );
			//
			MovieClip(this.info.getChildByName("copylinkClip")).gotoAndPlay("copied");
			//
			MovieClip(this.info.getChildByName("copylinkClip")).buttonMode = false;
			MovieClip(this.info.getChildByName("copylinkClip")).mouseEnabled = false;
			MovieClip(this.info.getChildByName("copylinkClip")).mouseChildren = false;				
			MovieClip(this.info.getChildByName("copylinkClip")).removeEventListener( MouseEvent.MOUSE_OVER, _handleMouseOver );
			MovieClip(this.info.getChildByName("copylinkClip")).removeEventListener( MouseEvent.MOUSE_OUT, _handleMouseOut );
			MovieClip(this.info.getChildByName("copylinkClip")).removeEventListener(  MouseEvent.CLICK, _handleClickURL );			
		}
		public function hide() : void
		{
			this.visible = false;		
		}		
	}
}