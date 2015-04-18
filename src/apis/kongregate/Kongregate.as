package apis.kongregate
{
	import apis.interfaces.ThirdParty;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.Security;
    /**
     * ...
     * @author Shaun Stone
     */
    public class Kongregate implements ThirdParty
    {
		// Pull the API path from the FlashVars
		private var paramObj:Object = LoaderInfo(root.loaderInfo).parameters;
		
		// The API path. The "shadow" API will load if testing locally. 
		private var apiPath:String = paramObj.kongregate_api_path || "http://www.kongregate.com/flash/API_AS3_Local.swf";
		
		private var kongregate:*;
		
        private var name:String = 'Kongregate';
        private var connected:Boolean = false;
        ;
        public function Kongregate()
        {
            trace("instantiated " + name + " API");
        }
		
		/* INTERFACE apis.interfaces.ThirdParty */
		
		public function connect():void 
		{
			// Load the API
			var request:URLRequest = new URLRequest(apiPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.load(request);
			this.addChild(loader);
		}
		
		// This function is called when loading is complete
		function loadComplete(event:Event):void
		{
			// Save Kongregate API reference
			kongregate = event.target.content;
		 
			// Connect to the back-end
			kongregate.services.connect();
			
			Security.allowDomain(kongregate.loaderInfo.url);
		 
			// You can now access the API via:
			// kongregate.services
			// kongregate.user
			// kongregate.scores
			// kongregate.stats
			// etc...
		}
		
		public function isConnected():Boolean 
		{
			return this.connected;
		}
		
		public function postScore(score:Number):Boolean 
		{
			
		}
    }
}