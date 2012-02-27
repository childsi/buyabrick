package childsifoundation.ui
{
	import flash.events.Event;
	
	import childsifoundation.assets.LandAsset;
	
	import mx.core.UIComponent;

	public class LandUI extends UIComponent
	{
		private var land : LandAsset;
		private var landObjects:Array;
		//
		public function LandUI()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, buildLand);
		}
		override protected function createChildren ( ) : void 
		{
			if ( !landObjects ) {
				// Detect that the land asset is = or > than the stage width.
				this.landObjects = new Array();
				
				var land:LandAsset =  new LandAsset ( ) ;
				this.landObjects.push(land);
				this.addChild ( land );
			}
		}			
		
		protected function buildLand (e : Event ) : void 
		{				
			var numOfGrass:int = Math.ceil(this.stage.stageWidth/(this.landObjects[0] as LandAsset).width);
			for (var i : int = 2; i <= numOfGrass; i++) {
				var newGrass:LandAsset =  new LandAsset ( ) ;
				landObjects.push(newGrass);
				newGrass.x = newGrass.width*(i-1);
				this.addChild ( newGrass );
			}
		}
	}
}