package videos
{
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

    /**
     * ...
     * @author Shaun Stone
     */
    public class SMKSIntro extends Sprite
    {
        private const PATH:String = "videos/smks.mp4";
        private const WIDTH:uint = 1024;
        private const HEIGHT:uint = 576;
        private var video:Video;
        private var nc:NetConnection;
        private var ns:NetStream;

        public function SMKSIntro()
        {
            addEventListener(Event.ADDED_TO_STAGE, added);
        }

        private function added(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, added);
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
			
			var offset:uint = 0;
			var height:uint = stage.stageHeight - offset;
			var positionY:uint = offset / 2;
			
            video = new Video(stage.stageWidth, height);
			video.y = positionY;
            video.smoothing = true;
            createStream();
            showVideo();
        }

        private function checkVideoExists():Boolean
        {
            var urlRequest:URLRequest = new URLRequest(PATH);
            var urlLoader:URLLoader = new URLLoader();
            urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
            urlLoader.addEventListener(Event.COMPLETE, urlLoader_complete);
            urlLoader.addEventListener(IOErrorEvent.IO_ERROR, urlLoader_error);
            if (urlLoader.load(urlRequest)) {
                return true;
            } else {
                return false;
            }
        }

        private function urlLoader_complete(evt:Event):void
        {
            trace("file found");
        }

        private function urlLoader_error(evt:IOErrorEvent):void
        {
            trace("file obviously not found");
        }

        private function showVideo():void
        {
            video.attachNetStream(ns);
            addChild(video);
        }

        private function createStream():void
        {
            nc = new NetConnection();
            nc.connect(null);
            ns = new NetStream(nc);
            //avoid error
            ns.client = {
                onMetaData: function (obj:Object):void
                {
                }
            }
            ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
            ns.addEventListener(NetStatusEvent.NET_STATUS, videoComplete);
            ns.play(PATH);
            video.attachNetStream(ns);
            addChild(video);
        }

        private function videoComplete(e:NetStatusEvent):void
        {
            if (e.info.code == 'NetStream.Play.Stop') {
                trace("video ended");
                parent.removeChild(this);
            }
        }

        private function asyncErrorHandler(e:AsyncErrorEvent):void
        {
            trace("async error occured!");
        }
    }
}