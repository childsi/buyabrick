package childsifoundation.ui
{
	import childsifoundation.model.ChildsFoundationModel;
	import childsifoundation.vo.BrickVO;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import mx.core.UIComponent;
	
	import org.nonpology.utils.MathX;
	
	public class WallUI extends UIComponent	
	{
		private var wall : Sprite;
		private var info : Sprite;
		private var infoLine : Sprite;
		private var infoData : BrickInfoPanelUI;
		private var blocker : Sprite;
		private var _deeplinkBrick : BrickUI;
		private var targetAlpha : Number = 0;
		private var targetX : Number = 0;
		private var targetY : Number = 0;
		private var brickX : Number = 0;
		private var brickY : Number = 0;	
		//
		private var brickSelected : Boolean = false;
		private var brickSelectedItem : BrickUI;
		private var deselectTimer:Timer;
		//
		private var drawn : Boolean = false;
		private var model : ChildsFoundationModel;
		//
		public function WallUI()
		{
			this.model = ChildsFoundationModel.getInstance();
			this.model.addEventListener( Event.COMPLETE, _handleBrickChange );
			//
			super();
		}
		override protected function createChildren ( ) : void 
		{
			if ( !drawn ) {
				drawn = true;
				drawWall();
			}
		}
		private function handleEnterFrame( e:Event ) : void
		{
			info.alpha += (( this.targetAlpha - info.alpha )*.1);
			if( info.alpha > .9 && targetAlpha == 1 ) { info.alpha = 1; } 
			if( info.alpha < .1 && targetAlpha == 0 ) { info.alpha = 0;	}
			//
			infoData.x += (( this.targetX - infoData.x )*.1);
			infoData.y += (( this.targetY - infoData.y )*.1);
			//
			infoLine.graphics.clear();
			infoLine.graphics.beginFill( 0xFFFFFF, 1 );
			infoLine.graphics.moveTo( this.brickX, this.brickY );
			infoLine.graphics.lineTo( infoData.x + (infoData.width/2), (infoData.y + (infoData.height/2)) - 10 );
			infoLine.graphics.lineTo( infoData.x + (infoData.width/2), (infoData.y + (infoData.height/2)) + 10 );
			infoLine.graphics.lineTo( this.brickX, this.brickY );
			infoLine.graphics.endFill();
		}
		private function _handleBrickChange( e:Event ) : void
		{
			drawBricks();
			drawInfo();
		}	
		protected function drawBricks() : void
		{
			var brick : BrickUI;
			var vo : BrickVO;
			//
			var numberRows : Number = 8;
			var numberItems : Number = 	(model.brickData.length + numberRows);
			var numerItemsInRows : Number = Math.ceil(numberItems/numberRows);
			var currentIndex : Number = 0;
			var currentWidth : Number = 0;
			//
			var rendersFully : Boolean = false;
			var tempNumberItemsInRows : Number = numerItemsInRows;
			var tempOutputCalculator : Number = 0;
			//
			trace("Actual Returned Bricks : " + model.brickData.length );
			trace("Total Bricks Loop : " + numberItems );
			trace("Number Bricks in Row : " + numerItemsInRows );
			//
			while( !rendersFully ) 
			{
				tempOutputCalculator = 0;
				//
				for( var k:int=0; k<=numberRows; k++ ) {
					for( var l:int=0; l<=tempNumberItemsInRows; l++ ) {
						tempOutputCalculator ++;
					}
					tempNumberItemsInRows--;
				}
				if( tempOutputCalculator < model.brickData.length ) {
					trace( tempOutputCalculator + " : " + model.brickData.length );
					tempNumberItemsInRows = numerItemsInRows++;	
					trace( "Increase Row Loop" )
				} else {
					numerItemsInRows++;
					rendersFully = true;
				}
			}
			trace("Calculated Number Bricks in Row : " + numerItemsInRows );
			//
			for( var i:int=0; i<=(numberRows+1); i++ ) {
				for( var j:int=0; j<=numerItemsInRows; j++ ) 
				{
					if( currentIndex >= numberItems ) { break; };
					//
					if( i == 0 ) {
						vo = new BrickVO();
						vo.loopIndex = currentIndex;
						brick = new BrickUI( vo );
						brick.buttonMode = false;
						brick.mouseEnabled = false;
						brick.mouseChildren = false;
					} else {
						try {
							vo = model.brickData.getItemAt( currentIndex++ ) as BrickVO;
							vo.loopIndex = currentIndex;
						} catch( e:Error ) {
							trace("tooo many rendered");
							break;
						}
						//						
						brick = new BrickUI( vo );
						brick.mouseEnabled = true;
						brick.mouseChildren = false;
						brick.buttonMode = true;
						brick.addEventListener( MouseEvent.CLICK, _handleMouseClickBrick );
						brick.addEventListener( MouseEvent.MOUSE_OVER, _handleMouseOverBrick );
						brick.addEventListener( MouseEvent.MOUSE_OUT, _handleMouseOutBrick );
						//
						if( model.applicationParams["linkBrick"] && vo.urlKey == model.applicationParams["linkBrick"] ) {
							_deeplinkBrick = brick;
							trace(" Matched Brick! " + brick)	
						}
					}
					brick.x = (j*55);
					brick.y = ((numberRows)*27) - (i*27);
					if( i % 2 == 1 ) { brick.x += 27; };
					//
					if( (brick.x + 58) > currentWidth ) {
						currentWidth = (brick.x + 58);
					}					
					//
					this.wall.addChild( brick );
				}
				numerItemsInRows--;
				//numerItemsInRows = MathX.constrain( numerItemsInRows, defaultNumberItemsInRow-6, defaultNumberItemsInRow );
			}
			//
			trace( " currentWidth " + currentWidth + " / " + stage.stageWidth );
			//
			//model.setWallWidth( 200 );
			//
			if( (currentWidth + 50) > stage.stageWidth ) {
				model.setWallScrollingNeeded(true);
			} else {
				model.setWallScrollingNeeded(false);
			}
			//
			invalidateSize();
			this.addEventListener( Event.ENTER_FRAME, handleEnterFrame );
		}
		public function getDeeplinkBrick() : BrickUI
		{
			return _deeplinkBrick;
		}
		protected function drawWall() : void
		{
			this.wall = new Sprite();
			//this.wall.scrollRect = new Rectangle( 0, 0, 550, 300 );
			this.addChild ( this.wall ) ;			
		}
		protected function drawInfo() : void
		{
			var color:Number = 0x000000;
            var alpha:Number = 0.8;
            var blurX:Number = 8;
            var blurY:Number = 8;
            var strength:Number = 1;
            var inner:Boolean = false;
            var knockout:Boolean = false;
            var quality:Number = BitmapFilterQuality.LOW;
			//
            var filter : GlowFilter = new GlowFilter(color,
                                  alpha,
                                  blurX,
                                  blurY,
                                  strength,
                                  quality,
                                  inner,
                                  knockout);
        	//			
			info = new Sprite();
			infoData = new BrickInfoPanelUI();
			
			infoLine = new Sprite();			
			info.addChild( infoLine );
			info.addChild( infoData );
			info.filters = [filter];
			info.cacheAsBitmap = true;
			//
			infoData.mouseEnabled = true;
			//
			blocker = new Sprite();
			blocker.buttonMode = true;
			blocker.mouseEnabled = true;
			blocker.mouseChildren = true;
			blocker.graphics.beginFill( 0xFFCC00, 1 );
			blocker.addEventListener( MouseEvent.CLICK, _handleBlockerClick );
			blocker.graphics.drawRect( 0, 0, wall.width, wall.height + 30 );
			blocker.graphics.endFill();
			blocker.alpha = 0;
			blocker.visible = false;
			blocker.y =- 30;
			//
			this.wall.addChild( blocker );
			this.wall.addChild( info );
		}
		private function _handleBlockerClick( e:MouseEvent ) : void
		{
			forceDeselect();
		}
		protected function _handleMouseOverBrick( e:MouseEvent ) : void
		{
			if( e.target is BrickUI && !brickSelected )
			{
				infoData.show( BrickUI(e.target).vo );
				//
				BrickUI(e.target).select();
				//
				this.brickX = BrickUI(e.target).x + 29;
				this.brickY = BrickUI(e.target).y + 14;
				//
				trace( BrickUI(e.target).localToGlobal( new Point(0,0) ).x + " vs " + e.stageX );	
				//
				if( e.stageX > (stage.stageWidth/2)  ) {
					this.targetX = MathX.constrain( (BrickUI(e.target).x - 300), 0, this.width - 260 );	
				} else {
					this.targetX = MathX.constrain( (BrickUI(e.target).x + 100), 0, this.width - 260 );
				}
				//
				if( this.brickY > wall.height/2 ) {
					this.targetY = MathX.constrain( (BrickUI(e.target).y - 100), 0, this.height - 260 );
				} else {
					this.targetY = MathX.constrain( (BrickUI(e.target).y - 400), 0, this.height - 260 );
				}
				//
				//info.buttonMode = true;
				//info.mouseEnabled = true;
				//			
				//
				e.stopImmediatePropagation();
				e.stopPropagation();
				//
				this.targetAlpha = 1;
			}
		}
		protected function _handleMouseOutBrick( e:MouseEvent ) : void
		{
			if( !brickSelected ) {
				this.targetAlpha = 0;
				//
				info.buttonMode = false;
				info.mouseEnabled = false;
				info.mouseChildren = false;				
				//
				BrickUI(e.target).deselect();
			}
		}	
		protected function _handleMouseClickBrick( e:MouseEvent ) : void
		{
			if( !brickSelected ) {
				brickSelected = true;
				brickSelectedItem = BrickUI(e.target);
				//
				info.mouseChildren = true;
				blocker.visible = true;				
				//
				deselectTimer = new Timer(2000);
				deselectTimer.addEventListener( TimerEvent.TIMER , autoDeselectActiveBrick );	
				deselectTimer.start();		
			}
		}	
		protected function autoDeselectActiveBrick( e:TimerEvent = null ) : void
		{
			if( !this.info.hitTestPoint( stage.mouseX, stage.mouseY, true ) ) { 
				forceDeselect();
			}
		}	
		protected function forceDeselect() : void
		{
			brickSelected = false;
			brickSelectedItem.deselect();
			this.targetAlpha = 0;
			blocker.visible = false;
			info.mouseChildren = false;	
			//
			if( deselectTimer ) {
				deselectTimer.stop();
				deselectTimer.removeEventListener( TimerEvent.TIMER , autoDeselectActiveBrick );
			}			
		}		
		public function showDeeplinkBrick() : void
		{
			brickSelectedItem = getDeeplinkBrick();
			//
			//
			if(model.applicationParams["isThanks"] != "true"){				
				infoData.show( brickSelectedItem.vo );
			} else {
				infoData.show( brickSelectedItem.vo, true, String(model.applicationParams["thanksMessage"]));
			}
			brickSelectedItem.select();
			//
			this.brickX = brickSelectedItem.x + 29;
			this.brickY = brickSelectedItem.y + 14;
			//
			//trace( brickSelectedItem.localToGlobal( new Point(0,0) ).x + " vs " + e.stageX );	
			//
			if( (brickSelectedItem.localToGlobal( new Point(0,0) ).x + 29) > (stage.stageWidth/2)  ) {
				this.targetX = MathX.constrain( (brickSelectedItem.x - 300), 0, this.width - 260 );	
			} else {
				this.targetX = MathX.constrain( (brickSelectedItem.x + 100), 0, this.width - 260 );
			}
			//
			if( this.brickY > wall.height/2 ) {
				this.targetY = MathX.constrain( (brickSelectedItem.y - 100), 0, this.height - 260 );
			} else {
				this.targetY = MathX.constrain( (brickSelectedItem.y - 400), 0, this.height - 260 );
			}
			//
			this.targetAlpha = 1;		
			//
			brickSelected = true;			
			info.mouseChildren = true;
			blocker.visible = true;					
		}
		override protected function measure ( ) : void {
			super.measure ( ) ;
			this.measuredWidth = this.wall.width;
			this.measuredHeight = this.wall.height;
		}				
	}
}