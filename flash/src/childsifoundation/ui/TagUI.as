package childsifoundation.ui
{
	import childsifoundation.assets.LargeTagAsset;
	import childsifoundation.assets.SmallTagAsset;
	import childsifoundation.model.ChildsFoundationModel;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.core.UIComponent;
	import mx.effects.Move;

	public class TagUI extends UIComponent
	{
		private var model : ChildsFoundationModel;
		//
		private var largeTag : LargeTagAsset;
		private var tag : SmallTagAsset;
		private var hitAsset : Sprite;
		//
		private var openMove : Move;
		private var isPlaying : Boolean = false;
		//
		public function TagUI()
		{
			super();
			//
			model = ChildsFoundationModel.getInstance();
			this.model.addEventListener( Event.COMPLETE, _handleBrickChange );
			//
			//this.setButtonMode ( ) ;
			//this.addMouseListeners ( ) ;			
		}
		override protected function createChildren ( ) : void 
		{
			if ( this.tag == null ) {
				this.tag = new SmallTagAsset ( ) ;
				this.addChild ( this.tag ) ;
			}
			//
			if ( this.largeTag == null ) {
				this.largeTag = new LargeTagAsset ( ) ;
				this.addChild ( this.largeTag ) ;
			}
			if ( this.hitAsset == null ) {
				this.hitAsset = new Sprite ( ) ;
				this.addChild ( this.hitAsset ) ;
				//
				setButtonMode();
			}			
		}
		private function _handleBrickChange( e:Event ) : void
		{
			TextField(this.largeTag.getChildByName("dateText")).text = model.dateTextValue;
			TextField(this.largeTag.getChildByName("bricksText")).text = model.brickTextValue;
			TextField(this.largeTag.getChildByName("moneyText")).text = "£" + model.moneyTextValue + "";
			//TextField(this.largeTag.getChildByName("messagesText")).text = model.messagesTextValue;
			//TextField(this.largeTag.getChildByName("countriesText")).text = model.countriesTextValue;
		}
		override protected function commitProperties ( ) : void {
			super.commitProperties ( ) ;
			//
			this.hitAsset.graphics.clear();
			this.hitAsset.graphics.beginFill( 0xFFCC00, 0 );
			this.hitAsset.graphics.lineTo( this.largeTag.width, 0 );
			this.hitAsset.graphics.lineTo( this.largeTag.width, this.largeTag.height );
			this.hitAsset.graphics.lineTo( this.largeTag.width - 65, this.largeTag.height );
			this.hitAsset.graphics.lineTo( this.largeTag.width - 65, this.largeTag.height+this.tag.height-10 );
			this.hitAsset.graphics.lineTo( this.largeTag.width - 102, this.largeTag.height+this.tag.height-10 );
			this.hitAsset.graphics.lineTo( this.largeTag.width - 102, this.largeTag.height );
			this.hitAsset.graphics.lineTo( 0, this.largeTag.height );
			this.hitAsset.graphics.lineTo( 0, 0 );
			this.hitAsset.graphics.endFill();
			//
			this.tag.x = 75;
			this.tag.y = (this.largeTag.height - 4);
		}
		//
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
		
		protected function setOverState (  ) : void {
		}

		protected function setOutState (  ) : void {
		}
				
	}
}