package childsifoundation.command
{
	import childsifoundation.event.IntroEvent;
	import childsifoundation.model.ChildsFoundationModel;
	import childsifoundation.vo.ApplicationState;
	
	import flash.events.Event;
	
	import org.nonpology.command.ChainedCommand;
	import org.nonpology.command.ICommand;
	//
	public class IntroCommand extends ChainedCommand implements ICommand
	{
		private var model : ChildsFoundationModel;
		//
		public function IntroCommand() : void
		{
			super();
			model = ChildsFoundationModel.getInstance();
		}
		public function execute( e:Event ) : void
		{
			switch ( e.type ) {
				case IntroEvent.ON_INTRO_START:
					model.applicationState = ApplicationState.INTRO;
					break;
				case IntroEvent.ON_INTRO_COMPLETE:
					model.applicationState = ApplicationState.WALL;
					break;	
				default:
					break;
			}
		}		
	}
}