package childsifoundation.ui
{
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	import mx.core.UIComponent;

	public class SliderBgUI extends UIComponent
	{
		private var shape : Sprite;
		//
		public function SliderBgUI()
		{
			super();
		}
		override protected function createChildren ( ) : void 
		{
			if ( this.shape == null ) 
			{
				var filter : DropShadowFilter = new DropShadowFilter ( 6, 180, 0x000000, .65, 4, 4, 1, 1 ) ;
				//				
				this.shape = new Sprite ( ) ;
				this.shape.graphics.beginFill( 0x515151, 1 );
				this.shape.graphics.drawRect( 0, 0, 800, 16 );
				this.shape.graphics.endFill();
				this.shape.x =- 5;
				this.shape.y =- 16;				
				this.addChild ( this.shape ) ;
				//
				this.shape.filters = [ filter ] ;
			}			
		}		
	}
}