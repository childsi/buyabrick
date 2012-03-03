package childsifoundation.ui
{
	import childsifoundation.assets.SkyAsset;
	import flash.display.Stage; 
	import flash.events.Event;
	
	import mx.core.UIComponent;

	public class SkyUI extends UIComponent
	{
		private var sky : SkyAsset;
		//
		public function SkyUI()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, buildSky);	
		}
		override protected function createChildren ( ) : void 
		{
			if ( this.sky == null ) {
				this.sky = new SkyAsset ( ) ;
				this.addChild ( this.sky ) ;
			}
		}	
		
		protected function buildSky (e : Event ) : void 
		{				
			this.sky.width = stage.stageWidth;
		}		
	}
}