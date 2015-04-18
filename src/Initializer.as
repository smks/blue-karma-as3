package
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.ContextMenuEvent;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;
    import flash.utils.getDefinitionByName;

    /**
     * ...
     * @author @shaun
     */
        //set the stage parameters
    [SWF(width="800", height="600", frameRate="60", backgroundColor="0x000000")]
    //[SWF(width="1024", height="768", frameRate="60", backgroundColor="0x000000")]
    public class Initializer extends MovieClip
    {
        private const PROGRESS_BAR_HEIGHT:Number = 20;
        // blue karma instance
        [Embed(source="../media/images/welcome-menu/watermark.png")]
        public static var GameWatermark:Class;
        private var _blueKarma:DisplayObject;
        private var customMenu:ContextMenu;
        private var notice:ContextMenuItem;
        // watermark on loading screen
        private var copyright:ContextMenuItem;
        private var _watermarkBm:Bitmap;

        public function Initializer()
        {
            // stop as this is a movieclip
            this.stop();
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            // set up custom context menu
            handleContextMenu();
            // add watermark while loading game
            addLoadingWatermark();
            // event preloading for game
            this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderInfoProgressHandler);
            this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfoCompleteHandler);
        }

        private function handleContextMenu():void
        {
            customMenu = new ContextMenu();
            // hide all right click options
            customMenu.hideBuiltInItems();
            var notice:ContextMenuItem = new ContextMenuItem("SMKS 2015");
            notice.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, openLink);
            customMenu.customItems.push(notice, copyright);
            // assign created to default
            contextMenu = customMenu;
        }

        private function openLink(e:ContextMenuEvent):void
        {
            navigateToURL(new URLRequest("http://www.smks.co.uk"), "_blank");
        }

        private function addLoadingWatermark():void
        {
            // new watermark instance
            _watermarkBm = new GameWatermark();
            // instance o bitmap data
            var bd:BitmapData = new BitmapData(_watermarkBm.width, _watermarkBm.height);
            // draw bitmap
            bd.draw(_watermarkBm, null, null, BlendMode.ALPHA);
            // set in middle of stage x
            _watermarkBm.x = (stage.stageWidth / 2) - (_watermarkBm.width / 2);
            // set in middle of stage y
            _watermarkBm.y = (stage.stageHeight / 2) - (_watermarkBm.height / 2);
            // add to stage
            addChild(_watermarkBm);
        }

        private function removeLoadingWatermark():void
        {
            removeChild(_watermarkBm);
        }

        private function loaderInfoProgressHandler(e:ProgressEvent):void
        {
            // this example draws a basic progress bar
            this.graphics.clear();
            this.graphics.beginFill(0x3466af);
            this.graphics.drawRect(0, (this.stage.stageHeight - PROGRESS_BAR_HEIGHT) / 2,
			this.stage.stageWidth * e.bytesLoaded / e.bytesTotal, PROGRESS_BAR_HEIGHT);
            this.graphics.endFill();
        }

        private function loaderInfoCompleteHandler(e:Event):void
        {
            // get rid of the progress bar
            this.graphics.clear();
            //remove watermark
            removeLoadingWatermark();
            // remove listeners
            this.loaderInfo.removeEventListener(ProgressEvent.PROGRESS, loaderInfoProgressHandler);
            this.loaderInfo.removeEventListener(Event.COMPLETE, loaderInfoCompleteHandler);
            startGame();
        }

        private function startGame():void
        {			
            //go to frame two because that's where the class exists
            this.gotoAndStop(2);
            // get definition by name class
            const BlueKarmaType:Class = getDefinitionByName("BlueKarma") as Class;
            // new instance of blue karma
            _blueKarma = new BlueKarmaType();
            // add to stage
            addChild(_blueKarma);
        }
    }
}