/**
 *
 * Blue Karma
 *
 * @version Flash Player 11.7
 * @copyright SMKS
 * @website smks.co.uk
 * @author Shaun Stone
 */
package
{
    import flash.display3D.Context3DProfile;

    import com.greensock.TweenLite;

    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.Stage3D;
    import flash.display.StageAlign;
    import flash.display.StageDisplayState;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.ProgressEvent;
    import flash.events.TouchEvent;
    import flash.geom.Rectangle;
    import flash.media.SoundMixer;
    import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;
    import flash.utils.getDefinitionByName;

    import global.Global;

    import mx.core.FlexTextField;

    import starling.core.Starling;
    import starling.events.ResizeEvent;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;
    import videos.IntroVideo;


    import bluekarma.videos.youtube.IntroVideoYouTube;

    import videos.SMKSIntro;

    import bluekarma.videos.youtube.SMKSIntroYouTube;

    import loaders.Preloader;

    import flash.display3D.Context3D;
    import flash.events.ContextMenuEvent;

    //main class container
    public class BlueKarma extends MovieClip
    {
        //environment constants
        public static const TESTING:String = "testing";
        public static const OFFLINE:String = "offline";
        public static const ONLINE:String = "online";
		static public const NAME:String = "Blue Karma";
        private static const PROGRESS_BAR_HEIGHT:Number = 20
        /**
         *
         * CHOOSE ENVIRONMENT
         *
         * TESTING || OFFLINE || ONLINE
         * This willl run based on what you choose
         **/
        public static var ENVIRONMENT:String = BlueKarma.TESTING;
        
        //api factory
        private var _smks:SMKSIntro;
        private var _smksOnline:SMKSIntroYouTube;
        private var _videoIntro:IntroVideo;
        private var _videoIntroOnline:IntroVideoYouTube;
        //starling instance
        private var _starling:Object;
        /**
         * pass in array of profiles
         * - baseline supports up to 2048
         * - baseline extended supports up to 4096
         */
        private var _context3DProfiles:Array = [
            "baseline", "baselineExtended", "auto"
        ];
        private var canSkipText:TextField;
        private var canSkipTextFormat:TextFormat;
        //constructor to initialise game
        public function BlueKarma():void
        {
            // stop as this is a movieclip
            this.stop();
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            //listen for resizing
            stage.addEventListener(ResizeEvent.RESIZE, resizeStage);
            //if (BlueKarma.ENVIRONMENT == OFFLINE) {
            //if (BlueKarma.ENVIRONMENT) {
            //  goFullScreen();
            //}
            switch (BlueKarma.ENVIRONMENT) {
                case BlueKarma.TESTING:
                    initGame();
                    break;
                default:
                    playSMKSIntro();
            }
        }

        private function playSMKSIntro():void
        {
            switch (BlueKarma.ENVIRONMENT) {
                case ONLINE :
                    _smksOnline = new SMKSIntroYouTube();
                    addChild(_smksOnline);
                    _smksOnline.addEventListener(Event.REMOVED_FROM_STAGE, showIntroVideo);
                    break;
                default :
                    _smks = new SMKSIntro();
                    addChild(_smks);
                    _smks.addEventListener(Event.REMOVED_FROM_STAGE, showIntroVideo);
                    break;
            }
        }

        private function showIntroVideo(e:Event):void
        {
            removeLogoIntroListeners();
            addSkipListener();
            switch (BlueKarma.ENVIRONMENT) {
                case BlueKarma.ONLINE :
                    playYoutubeIntro();
                    break;
                default :
                    playLocalIntro();
            }
            addCanSkipTest();
        }

        private function addCanSkipTest():void
        {
            canSkipText = new TextField();
            canSkipText.text = "Touch or Click Screen to Skip Intro";
            canSkipText.autoSize = TextFieldAutoSize.LEFT;
            canSkipText.x = 20;
            //canSkipText.border = true;
            //canSkipText.borderColor = 0xffffff;
            canSkipText.y = stage.stageHeight - canSkipText.height - 20;
            canSkipText.alpha = 0;
            canSkipTextFormat = new TextFormat();
            canSkipTextFormat.font = Global.DEFAULT_FONT;
            canSkipTextFormat.color = Global.BLUE_KARMA_WHITE;
            canSkipTextFormat.size = 15;
            canSkipText.setTextFormat(canSkipTextFormat);
            TweenLite.to(canSkipText, 5, {alpha: 1, delay: 5, onComplete: fadeOutText});
            function fadeOutText():void
            {
                TweenLite.to(canSkipText, 5, {alpha: 0});
            }

            addChild(canSkipText);
        }

        private function addSkipListener():void
        {
            addEventListener(MouseEvent.CLICK, skipHandler);
        }

        /**
         *
         * @param e
         */
        private function skipHandler(e:MouseEvent):void
        {
            flash.media.SoundMixer.stopAll();
            if (_videoIntro !== null && this.contains(_videoIntro)) {
                removeChild(_videoIntro);
                _videoIntro = null;
            } else if (_videoIntroOnline !== null && this.contains(_videoIntroOnline)) {
				_videoIntroOnline.stop();
                removeChild(_videoIntroOnline);
                _videoIntroOnline = null;
            }
        }

        private function playYoutubeIntro():void
        {
            _videoIntroOnline = new IntroVideoYouTube();
            addChild(_videoIntroOnline);
            _videoIntroOnline.addEventListener(Event.REMOVED_FROM_STAGE, prepareGame);
        }

        private function playLocalIntro():void
        {
            _videoIntro = new IntroVideo();
            addChild(_videoIntro);
            _videoIntro.addEventListener(Event.REMOVED_FROM_STAGE, prepareGame);
        }

        /**
         *
         * @param e
         */
        private function prepareGame(e:Event):void
        {
            if (hasEventListener(MouseEvent.CLICK)) {
                removeEventListener(MouseEvent.CLICK, skipHandler);
            }
            // remove listener and prepare game
            removeCreditsIntroListener();
            //initialise game
            initGame();
        }

        /**
         * Initialises starling game
         */
        private function initGame():void
        {
            if (canSkipText !== null) {
                removeChild(canSkipText);
            }
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_BORDER;
            //getDefinitionByName() will let us access the classes without importing
            const StarlingType:Class = getDefinitionByName("starling.core.Starling") as Class;
            const MainType:Class = getDefinitionByName("Game") as Class;
            // get viewport based on state
            var viewPortRectangle:Rectangle = getViewPortRectangle();
            // handle any lost context
            //StarlingType.handleLostContext = true;
            StarlingType.handleLostContext = false;
            //instantiate starling framework
            //_starling = new Starling(Game, stage, viewPortRectangle, null, "auto", "baseline");
            _starling = new StarlingType(
                    MainType, stage, viewPortRectangle, null, "auto", _context3DProfiles[1]
            );
            // Define basic anti aliasing.
            _starling.antiAliasing = 1;
            _starling.supportHighResolutions = true;
            // only show stats if in testing environment
            if (BlueKarma.ENVIRONMENT == TESTING) {
				// Position stats.
				_starling.showStatsAt("left", "bottom");
			}
            // simulate multi touch
            _starling.simulateMultitouch = false;
            //}
            // set view port
            StarlingType.current.viewPort = getViewPortRectangle();
            // Start Starling Framework.
            _starling.start();
            // set stage and height for starling instance
            _starling.stage.stageWidth = Game.STAGE_WIDTH;
            _starling.stage.stageHeight = Game.STAGE_HEIGHT;
        }

        private function goFullScreen():void
        {
            stage.displayState = StageDisplayState.FULL_SCREEN;
        }

        private function exitFullScreen():void
        {
            stage.displayState = StageDisplayState.NORMAL;
        }

        private function resizeStage(event:Event):void
        {
            var vpr:Rectangle = getViewPortRectangle();
            if (_starling !== null) {
                Starling.current.viewPort = vpr;
                _starling.stage.stageWidth = 1024;
                _starling.stage.stageHeight = 768;
            }
        }

        private function getViewPortRectangle():Rectangle
        {
            var viewPortRectangle:Rectangle;
            switch (stage.displayState) {
                case StageDisplayState.FULL_SCREEN, StageDisplayState.FULL_SCREEN_INTERACTIVE :
                    viewPortRectangle = RectangleUtil.fit(
                            new Rectangle(0, 0, stage.stageWidth, stage.stageHeight),
                            new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight),
                            ScaleMode.SHOW_ALL
                    );
                    break;
                default :
                    viewPortRectangle = new Rectangle();
                    viewPortRectangle.width = stage.stageWidth;
                    viewPortRectangle.height = stage.stageHeight;
                    break;
            }
            return viewPortRectangle;
        }

        private function removeLogoIntroListeners():void
        {
            if (BlueKarma.ENVIRONMENT === BlueKarma.ONLINE) {
                _smksOnline.removeEventListener(Event.REMOVED_FROM_STAGE, showIntroVideo);
            }
            if (BlueKarma.ENVIRONMENT === BlueKarma.OFFLINE) {
                _smks.removeEventListener(Event.REMOVED_FROM_STAGE, showIntroVideo);
            }
        }

        private function removeCreditsIntroListener():void
        {
            if (BlueKarma.ENVIRONMENT === BlueKarma.ONLINE) {
                _videoIntroOnline.removeEventListener(Event.REMOVED_FROM_STAGE, prepareGame);
            }
            if (BlueKarma.ENVIRONMENT === BlueKarma.OFFLINE) {
                _videoIntro.removeEventListener(Event.REMOVED_FROM_STAGE, prepareGame);
            }
        }
    }
}