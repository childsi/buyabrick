package childsifoundation.ui
{
	import childsifoundation.assets.QuickSlideAsset;
	import childsifoundation.event.ScrollEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	
	import org.nonpology.control.ApplicationEventDispatcher;

	//[Event(name="onScroll", type="childsifoundation.event.ScrollEvent")]
	public class SliderUI extends UIComponent
	{
		private var slider : QuickSlideAsset;
		private var hitAsset : Sprite;
		//
		private var previousX : Number = 0;
		//
		public function SliderUI()
		{
			super();		
		}
		override protected function createChildren ( ) : void 
		{
			if ( this.slider == null ) {
				this.slider = new QuickSlideAsset ( ) ;
				this.addChild ( this.slider ) ;
			}
			if ( this.hitAsset == null ) {
				this.hitAsset = new Sprite() ;
				this.hitAsset.graphics.clear();
				this.hitAsset.graphics.beginFill( 0xFFCC00, 0 );				
				this.hitAsset.graphics.drawRect( 0, 0, 105, 45 );
				this.hitAsset.graphics.endFill();
				this.hitAsset.y =- 17;
				this.addChild ( this.hitAsset ) ;
				//
				//addMouseListeners();
				setButtonMode();
			}							
		}
		protected function setButtonMode ( ) : void { 
			this.hitArea = hitAsset; 
			this.buttonMode = true ;
			this.mouseEnabled = true ;
			this.mouseChildren = false;
		}
		
		protected function disableButtonMode ( ) : void {
			this.buttonMode = false ;
			this.mouseEnabled = false ;
		}
		
		protected function addMouseListeners ( ) : void {
			this.addEventListener ( MouseEvent.ROLL_OVER , this.onRollOver ) ;
			this.addEventListener ( MouseEvent.ROLL_OUT , this.onRollOut ) ;
		}
		
		protected function removeMouseListeners ( ) : void {
			this.removeEventListener ( MouseEvent.ROLL_OVER , this.onRollOver ) ;
			this.removeEventListener ( MouseEvent.ROLL_OUT , this.onRollOut ) ;
		}
		
		protected function onAddedToStage ( event:Event ) : void {
			this.removeEventListener ( Event.ADDED_TO_STAGE , this.onAddedToStage ) ;
			this.addMouseListeners ( ) ;
		}
		
		protected function onRollOver ( event:MouseEvent ) : void {
			this.setOverState ( ) ;
		}
		
		protected function onRollOut ( event:MouseEvent ) : void {
			this.setOutState ( ) ;
		}		
		
		public function setOverState (  ) : void {
			this.slider.gotoAndStop( 2 );			
		}
		
		public function setClickState() : void
		{
			this.startDrag( false, new Rectangle( 0, 0, stage.stageWidth - 115, 0 ) );
			this.addEventListener( Event.ENTER_FRAME, _dispatchScroll );
		}
		
		private function _dispatchScroll( e:Event ) : void
		{
			if( this.x != previousX ) {
				previousX = this.x;
				var event : ScrollEvent = new ScrollEvent( ScrollEvent.ON_SCROLL, this.x, (stage.stageWidth-115) );
				//dispatchEvent( event )
				ApplicationEventDispatcher.getInstance().dispatchEvent( event )
			}
		}

		public function setReleaseState() : void
		{
			this.stopDrag();
			this.removeEventListener( Event.ENTER_FRAME, _dispatchScroll );
		}		

		public function setOutState (  ) : void {
			this.slider.gotoAndStop( 1 );
			
		}
				
	}
}