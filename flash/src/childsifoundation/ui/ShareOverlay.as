package childsifoundation.ui
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.Security;
	//
	public class ShareOverlay extends Sprite
	{
		private var mcWF : MovieClip;
		private var urlReq : URLRequest;
		private var ldr : Loader;
		//
		public function ShareOverlay()
		{
			super();
			//
			Security.allowDomain("cdn.gigya.com");
			Security.allowInsecureDomain("cdn.gigya.com");
			//
			render();
		}
		private function render() : void
		{
			this.visible = false;
			//
			if( mcWF != null ) { mcWF.visible = true; return; }
			mcWF = new MovieClip();
			addChild(mcWF).name='mcWF';
			//
			var ModuleID:String='PostModule1';// pass the module id to wildfire
			var cfg:Object = { };
			//
			cfg['width']='236';
			cfg['height']='179';
			cfg['partner']='426593';
			cfg['UIConfig']='<config><display showDesktop="false" showEmail="false" useTransitions="true" showBookmark="false" codeBoxHeight="auto" showCloseButton="true"></display><body><background frame-color="#BFBFBF" background-color="#FFFFFF" gradient-color-begin="#ffffff" gradient-color-end="#F4F4F4" corner-roundness="15"></background><controls color="#202020" corner-roundness="4;4;4;4" gradient-color-begin="#EAEAEA" gradient-color-end="#F4F4F4" bold="false"><snbuttons iconsOnly="true" type="textUnder" frame-color="#D5D5D5" background-color="#fafafa" over-frame-color="#60BFFF" over-background-color="#ebebeb" color="#808080" gradient-color-begin="#FFFFFF" gradient-color-end="d4d6d7" size="10" bold="false" down-frame-color="#60BFFF" down-gradient-color-begin="#6DDADA" over-gradient-color-end="#6DDADA" down-gradient-color-end="#F4F4F4" over-color="#52A4DA" down-color="#52A4DA" over-bold="false"><more frame-color="#A4DBFF" over-frame-color="#A4DBFF" gradient-color-begin="#F4F4F4" gradient-color-end="#BBE4FF" over-gradient-color-begin="#A4DBFF" over-gradient-color-end="#F4F4F4"></more><previous frame-color="#BBE4FF" over-frame-color="#A4DBFF" gradient-color-begin="#FFFFFF" gradient-color-end="#A4DBFF" over-gradient-color-begin="#A4DBFF" over-gradient-color-end="#F4F4F4"></previous></snbuttons><textboxes frame-color="#CACACA" color="#757575" gradient-color-begin="#ffffff" bold="false"><codeboxes color="#757575" frame-color="#DFDFDF" background-color="#FFFFFF" gradient-color-begin="#ffffff" gradient-color-end="#FFFFFF" size="10"></codeboxes><inputs frame-color="#CACACA" color="#757575" gradient-color-begin="#F4F4F4" gradient-color-end="#ffffff"></inputs><dropdowns list-item-over-color="#52A4DA" frame-color="#CACACA"></dropdowns></textboxes><buttons frame-color="#CACACA" gradient-color-begin="#F4F4F4" gradient-color-end="#CACACA" color="#000000" bold="false" over-frame-color="#60BFFF" over-gradient-color-begin="#BBE4FF" down-gradient-color-begin="#BBE4FF" over-gradient-color-end="#FFFFFF" down-gradient-color-end="#ffffff"><post-buttons frame-color="#CACACA" gradient-color-end="#CACACA"></post-buttons></buttons><listboxes frame-color="#CACACA" corner-roundness="4;4;4;4" gradient-color-begin="#F4F4F4" gradient-color-end="#FFFFFF"></listboxes><checkboxes checkmark-color="#00B600" frame-color="#D5D5D5" corner-roundness="3;3;3;3" gradient-color-begin="#F4F4F4" gradient-color-end="#FFFFFF"></checkboxes><servicemarker gradient-color-begin="#ffffff" gradient-color-end="#D5D5D5"></servicemarker><tooltips color="#6D5128" gradient-color-begin="#FFFFFF" gradient-color-end="#FFE4BB" size="10" frame-color="#FFDBA4"></tooltips></controls><texts color="#202020"><headers color="#202020"></headers><messages color="#202020"></messages><links color="#52A4DA" underline="false" over-color="#353535" down-color="#353535" down-bold="false"></links></texts></body></config>';
			// Please set up the content to be posted
			cfg['defaultContent']= '<img style="visibility:hidden;width:0px;height:0px;" border=0 width=0 height=0 src="http://counters.gigya.com/wildfire/IMP/CXNID=2000002.0NXC/bT*xJmx*PTEyNDI*NzEwNDAzOTYmcHQ9MTI*MjQ3MTIyMzExOSZwPTQyNjU5MyZkPSZnPTImdD*mbz1jMzc4NzJkN2ExZjg*NzQzYjk2OWJlN2YyZTEwOTM1MiZvZj*w.gif" /><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="250" height="260" id="WFHost"><param name="FlashVars" value="Partner=426593&theme=New Classic&widgetW=250&widgetH=260&widgetX=0&widgetY=0&stickyType=&WFBtnX=80&WFBtnY=220&previewURL=&URL=http%3A%2F%2Fdev.ichilds.rorymacdonald.net%2Fichildswidget.swf"/><param name="wmode" value="transparent"/><param name="allowScriptAccess" value="always" /><param name="movie" value="http://cdn.gigya.com/wildfire/swf/WildfireHost.swf" />   <embed name="WFHost" id="WFHost" width="250" height="260" src="http://cdn.gigya.com/wildfire/swf/WildfireHost.swf" flashvars="Partner=426593&theme=New Classic&widgetW=250&widgetH=260&widgetX=0&widgetY=0&stickyType=&WFBtnX=80&WFBtnY=220&previewURL=&URL=http%3A%2F%2Fdev.ichilds.rorymacdonald.net%2Fichildswidget.swf" AllowScriptAccess="always" quality="high" wmode="transparent" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" /></object>'; // <-- YOUR EMBED CODE GOES HERE 
			ldr = new Loader();
			ldr.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, _handleIOError );
			// set up an event handler for the onClose event, this is called when the Wildfire UI is closed.
			cfg['onClose']=function(eventObj:Object):void{
			    mcWF.visible = false;
			    ldr.content['INIT']();
			    //you can do additional cleanup here
			}			
			// This code calls up wildfire 
			var url:String = 'http://cdn.gigya.com/WildFire/swf/wildfireInAS3.swf?ModuleID=' + ModuleID;
			urlReq = new URLRequest(url);
			mcWF[ModuleID] = cfg;
			ldr.load(urlReq);
			mcWF.addChild(ldr);			
		}	
		private function _handleIOError( e:IOErrorEvent ) : void
		{
			trace("IOError");	
		}
		public function show() : void
		{
			if( mcWF != null ) { mcWF.visible = true; }			
			this.visible = true;		
		}
		public function hide() : void
		{
			this.visible = false;		
		}		
	}
}