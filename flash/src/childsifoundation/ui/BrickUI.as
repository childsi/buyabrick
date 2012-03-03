package childsifoundation.ui {
	import flash.geom.ColorTransform;	
	
	import childsifoundation.assets.BrickAsset;
	import childsifoundation.vo.BrickVO;
	import childsifoundation.model.ChildsFoundationModel;
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.text.TextField;
	//
	public class BrickUI extends Sprite
	{
		private var model : ChildsFoundationModel;
		private var brick : BrickAsset;
		public var vo : BrickVO;
		//
		public function BrickUI( vo:BrickVO )
		{
			super();
			//
			this.vo = vo;
			model = ChildsFoundationModel.getInstance();
			//
			createChildren();
		}
		protected function createChildren ( ) : void 
		{
			if ( this.brick == null ) {
				this.brick = new BrickAsset ( ) ;
				//TextField(this.brick.getChildByName("id")).text = "" + vo.loopIndex + "";
				
				deselect();
				this.addChild ( this.brick );
			}
		}	
		public function select() : void
		{
			//this.brick.gotoAndStop( "over" );
			// Set brick colour 
			if(model.applicationParams[vo.colour]){
				var colorTransform : ColorTransform = MovieClip(this.brick.getChildByName("brickColour")).transform.colorTransform;
				colorTransform.color = uint(model.applicationParams[vo.colour+"_rollover"]);
				MovieClip(this.brick.getChildByName("brickColour")).transform.colorTransform = colorTransform;
			}
		}	
		public function deselect() : void
		{
			//this.brick.gotoAndStop( vo.brickFrame+ "_brick" );
			// Set brick colour 
			if(model.applicationParams[vo.colour]){
				var colorTransform : ColorTransform = MovieClip(this.brick.getChildByName("brickColour")).transform.colorTransform;
				colorTransform.color = uint(model.applicationParams[vo.colour]);
				MovieClip(this.brick.getChildByName("brickColour")).transform.colorTransform = colorTransform;
			}
		}			
	}
}