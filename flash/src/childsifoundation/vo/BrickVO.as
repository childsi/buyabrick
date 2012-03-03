package childsifoundation.vo
{
	import org.nonpology.utils.MathX;
	//
	public class BrickVO
	{
		public var brickFrame : Number
		public var lastName : String;
		public var displayName : String;
		public var value : Number;
		public var iconId : String;
		public var colour : String;
		public var urlKey : String;
		public var message : String = "";
		public var firstName : String;
		public var fullURL : String;

		/*
		public var brickName : String = "";
		public var colour : String;
		public var createdAt : String;
		public var email : String;
		
		public var iconId : String;
		public var id : String;
		
		public var message : String;
		public var naughty : String;
		public var postcode : String;
		public var purchasedAt : String;
		public var showValue : Boolean;
		public var twitter : String;
		public var updatedAt : String;
		public var url : String;
		public var urlKey : String;		
		*/
		public var loopIndex : Number = 0;
		//
		public function BrickVO()
		{
			//brickFrame = MathX.randInt( 1, 6 );
		}

	}
}