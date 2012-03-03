package childsifoundation.command
{
	import childsifoundation.event.ScrollEvent;
	import childsifoundation.model.ChildsFoundationModel;
	
	import flash.events.Event;
	
	import org.nonpology.command.ChainedCommand;
	import org.nonpology.command.ICommand;

	public class WallScrollCommand extends ChainedCommand implements ICommand
	{
		private var model : ChildsFoundationModel;
		//		
		public function WallScrollCommand()
		{
			super();
			model = ChildsFoundationModel.getInstance();
		}
		//
		public function execute( e:Event ) : void
		{
			switch ( e.type ) {
				case ScrollEvent.ON_SCROLL:
					model.scrollPercentage = ScrollEvent(e).reversePercentage;
					//trace( e + " / " + ScrollEvent(e).scrollPercentage );
					break;	
				default:
					break;
			}			
		}		
	}
}