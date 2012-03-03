package childsifoundation.ui
{
	import flash.events.Event;
	
	import childsifoundation.assets.SunAsset;
	
	import mx.core.UIComponent;

	public class SunUI extends UIComponent
	{
		private var degrees : Number = 0;
		private var targetAngle : Number = 240;
		private var originX : Number = 130;
		private var originY : Number = 125;
		private var speed : Number = 0.05;
		private var radiusX : Number = 330;
		private var radiusY : Number = 200;
		private var rads : Number = degrees * (Math.PI / 180);
		//
		private var delay : Number = 150;
		private var delayElapsed : Number = 0;
		//
		private var sun : SunAsset;
		//
		public function SunUI()
		{
			super();
			//
			startSun();
		}
		override protected function createChildren ( ) : void 
		{
			if ( this.sun == null ) {
				this.sun = new SunAsset ( ) ;
				this.addChild ( this.sun ) ;
				//
				renderSun();
			}
		}		
		private function startSun() : void
		{
			this.addEventListener( Event.ENTER_FRAME, this.moveSun );
		}
		private function moveSun( e:Event ) :void
		{
			if( delayElapsed++ > delay ) 
			{
				renderSun();
			}
		}
		private function renderSun() : void
		{
			var rad :Number = this.targetAngle * (Math.PI / 180);
			this.sun.x = this.originX + this.radiusX * Math.cos(rad);
			this.sun.y = this.originY + this.radiusY * Math.sin(rad);
			//
			this.targetAngle += this.speed
			this.targetAngle %= 360;
			//
			if( this.targetAngle > 350 ) { this.targetAngle = 180; }			
		}						
	}
}