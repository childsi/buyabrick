package childsifoundation.control
{
	import childsifoundation.command.IntroCommand;
	import childsifoundation.command.WallScrollCommand;
	import childsifoundation.event.IntroEvent;
	import childsifoundation.event.ScrollEvent;
	
	import org.nonpology.application.control.ApplicationController;

	public class ChildsFoundationController extends ApplicationController {
		
		public function ChildsFoundationController ( ) {
			super ( ) ;
			//
			this.addCommand( IntroEvent.ON_INTRO_START, IntroCommand );
			this.addCommand( IntroEvent.ON_INTRO_COMPLETE, IntroCommand );
			//
			this.addCommand( ScrollEvent.ON_SCROLL, WallScrollCommand );
		}		
	}
}