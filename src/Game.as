package
{
    //import starling classes
    import assets.RileyApartmentAssets;

    import starling.core.Starling;

    import bluekarma.previews.Preview;

    import flash.automation.MouseAutomationAction;

    import levels.base.RileysApartment;
    import levels.level1.Level1;
    import levels.level1.part1.RileysApartmentIntro;
    import levels.level1.part2.RileysJourneyAlbert;
    import levels.level1.part3.SlumsStreet;

    import settings.foregrounds.ForegroundRileysApartment;
    import settings.foregrounds.Overlay;

    import starling.display.Sprite;
    import starling.events.Event;

    import tests.Test;

    import videos.IntroVideo;

    import bluekarma.videos.youtube.IntroVideoYouTube;

    //add tests
    //import welcome screen
    import screens.WelcomeMenu;

    //import levels
    import settings.backgrounds.BackgroundRileysApartment;

    /**
     * ...
     * @author Shaun Stone
     */
    public class Game extends Sprite
    {
        public static const STAGE_WIDTH:uint = 1024;
        public static const STAGE_HEIGHT:uint = 768;
        public static const SCREEN_CHANGE:String = "change";
        public static const WELCOME:String = "welcome";
        public static const LEVEL_1:String = "level1";
        public static const LEVEL_2:String = "level2";
        public static const LEVEL_3:String = "level3";
        private var _welcomeScreen:WelcomeMenu;
        private var _currentLevel:uint;
        // Levels
        private var level1:Level1;

        public function Game()
        {
            super();
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        public function getCurrentLevel():uint
        {
            return _currentLevel;
        }

        public function setCurrentLevel(value:uint):void
        {
            _currentLevel = value;
        }

        private function onAddedToStage(e:Event):void
        {
            //set up the game
            composeGame();
            //remove event listener
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function composeGame():void
        {

            //this will listen for any events that demand to change screen/level
            addScreenChangeListener();
            switch (BlueKarma.ENVIRONMENT) {
                case BlueKarma.TESTING:

                    //runWelcomeMenu();
                    //addLevelOne();
                    addPreview();
                    break;
                default:
                    runWelcomeMenu();
            }
        }

        /**
         * This will listen for any event dispatches to change level
         */
        private function addScreenChangeListener():void
        {
            addEventListener(SCREEN_CHANGE, handleScreenChange);
        }

        private function handleScreenChange(e:Event):void
        {
            switch (e.data.screen) {
                case WELCOME:
                    _welcomeScreen.cleanUp();
                    removeChild(_welcomeScreen, true);
                    addLevelOne();
                    break;
                case LEVEL_1 :
                    break;
                default :
                    throw new Error("Haven't got this far yet, jheez");
            }
        }

        /**
         * add welcome screen
         */
        private function runWelcomeMenu():void
        {
            _welcomeScreen = new WelcomeMenu();
            addChild(_welcomeScreen);
        }

        /**
         * first level of the game
         */
        private function addLevelOne():void
        {
            level1 = new Level1();
            addChild(level1);
            // By default will run from the beginning
            level1.finishedAct();
        }

        /**
         * @desc use to run tests
         */
        private function addPreview():void
        {
            var preview:Preview = new Preview();
            addChild(preview);
        }
    }
}