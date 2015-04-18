package bluekarma.videos.youtube
{
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.events.Event;
    import flash.media.StageVideo;
    import flash.display.StageScaleMode;
    import flash.events.AsyncErrorEvent;
    import flash.events.NetStatusEvent;
    import flash.media.Video;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLLoaderDataFormat;
    import flash.events.IOErrorEvent;
    import flash.display.Stage;
    import flash.system.Security;
    import flash.text.TextField;

    /**
     * @author Shaun Stone
     */
    public class IntroVideoYouTube extends Sprite
    {
        private static const DEFAULT_VIDEO_ID:String = "_g38pZ3LdC4";
        private static const PLAYER_URL:String = "http://www.youtube.com/apiplayer?version=3";
        private static const SECURITY_DOMAIN:String = "www.youtube.com";
        private static const YOUTUBE_API_PREFIX:String = "http://gdata.youtube.com/feeds/api/videos/";
        private var _player:Object;
        // CONSTANTS.
        private var _loader:Loader;
        private var youtubeUrlLoader:URLLoader;
        private var _stage:Stage;
        private var _skipText:TextField;

        public function IntroVideoYouTube()
        {
            addEventListener(Event.ADDED_TO_STAGE, added);
        }

        private function added(e:Event):void
        {
            trace("added()");
            removeEventListener(Event.ADDED_TO_STAGE, added);
            //allow access
            Security.allowDomain(SECURITY_DOMAIN);
            Security.allowDomain("http://s.ytimg.com");
            setupPlayerLoader();
            setupYoutubeApiLoader();
        }

        private function setupPlayerLoader():void
        {
            trace("setupPlayerLoader()");
            _loader = new Loader();
            _loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
            _loader.load(new URLRequest(PLAYER_URL));
        }

        private function setupYoutubeApiLoader():void
        {
            trace("setupYoutubeApiLoader()");
            youtubeUrlLoader = new URLLoader();
            youtubeUrlLoader.addEventListener(IOErrorEvent.IO_ERROR, youtubeApiLoaderErrorHandler);
            youtubeUrlLoader.addEventListener(Event.COMPLETE, youtubeApiLoaderCompleteHandler);
        }

        private function onLoaderInit(e:Event):void
        {
            trace("onLoaderInit()");
            addChild(_loader);
            _loader.content.addEventListener("onReady", onPlayerReady);
            _loader.content.addEventListener("onError", onPlayerError);
            _loader.content.addEventListener("onStateChange", onPlayerStateChange);
            _loader.content.addEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
        }

        private function youtubeApiLoaderCompleteHandler(e:Event):void
        {
            trace("youtubeApiLoaderCompleteHandler");
            _player.loadVideoById(DEFAULT_VIDEO_ID);
        }

        private function youtubeApiLoaderErrorHandler(e:IOErrorEvent):void
        {
            trace("video load failed");
        }

        private function onPlayerReady(e:Event):void
        {
            trace("onPlayerReady()");
            _player = _loader.content;
            _player.setSize(stage.stageWidth, stage.stageHeight);
            _player.loadVideoById(DEFAULT_VIDEO_ID);
        }

        private function onPlayerError(event:Event):void
        {
            trace("onPlayerError()");
            trace("player error:", Object(event).data);
        }

        private function onPlayerStateChange(event:Event):void
        {
            //if player has ended playing content
            if (Object(event).data == 0) {
                removeListeners();
                parent.removeChild(this);
            }
        }

        private function onVideoPlaybackQualityChange(event:Event):void
        {
            trace("player playQ:", Object(event).data);
        }

        private function removeListeners():void
        {
            if (_loader.hasEventListener("onReady")) {
                trace("removing listeners");
                _loader.content.removeEventListener("onReady", onPlayerReady);
                _loader.content.removeEventListener("onError", onPlayerError);
                _loader.content.removeEventListener("onStateChange", onPlayerStateChange);
                _loader.content.removeEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
            }
        }
		
		public function stop():void
		{
			_player.stopVideo();
		}
    }
}