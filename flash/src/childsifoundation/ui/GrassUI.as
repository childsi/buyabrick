package childsifoundation.ui
{
	import childsifoundation.assets.GrassAsset;
	import flash.display.Stage; 
	import flash.events.Event;
	import mx.core.UIComponent;

	public class GrassUI extends UIComponent
	{
		private var grassObjects:Array;
		//
		public function GrassUI()
		{
			super();
			//
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.buttonMode = false;		
			
			this.addEventListener(Event.ADDED_TO_STAGE, buildGrass);	
		}
		override protected function createChildren ( ) : void 
		{
			if ( !this.grassObjects) {
				// Detect that the grass asset is = or > than the stage width.
				this.grassObjects = new Array();
				
				var grass:GrassAsset =  new GrassAsset ( ) ;
				this.grassObjects.push(grass);
				this.addChild ( grass );
			}
		}
		
		protected function buildGrass (e : Event ) : void 
		{				
			var numOfGrass:int = Math.ceil(this.stage.stageWidth/(this.grassObjects[0] as GrassAsset).width);
			for (var i : int = 2; i <= numOfGrass; i++) {
				var newGrass:GrassAsset =  new GrassAsset ( ) ;
				grassObjects.push(newGrass);
				newGrass.x = newGrass.width*(i-1);
				this.addChild ( newGrass );
			}
		}			
	}
}