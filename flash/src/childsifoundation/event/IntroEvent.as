package childsifoundation.event
{
	import flash.events.Event;

	public class IntroEvent extends Event
	{
		public static const ON_INTRO_START : String = "onIntroStart";
		public static const ON_INTRO_COMPLETE : String = "onIntroComplete";
		//
		public var blahX : String;
		//
		public function IntroEvent( type:String, blah:String = "" )
		{
			super(type);
			//
			this.blahX = blah
		}
		
	}
}