package childsifoundation.event
{
	import flash.events.Event;
	//
	import org.nonpology.utils.MathX;
	//
	public class ScrollEvent extends Event
	{
		public static const ON_SCROLL : String = "onScroll";
		//
		public var scrollPercentage : Number = 0;
		public var reversePercentage : Number = 0;		
		public var scrollValue : Number = 0;
		public var scrollTotal : Number = 0;
		//
		public function ScrollEvent( type:String, val:Number, tot:Number )
		{
			super(type);
			//
			scrollValue = val;
			scrollTotal = tot;
			scrollPercentage = MathX.percentage( scrollValue, scrollTotal );
			reversePercentage = (100 - scrollPercentage);
		}
		
	}
}