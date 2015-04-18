package bluekarma.levels.abstract
{
    //starling framework classes
    import bluekarma.interactive.base.Item;

    import interactive.apartment.props.bedroom.BedroomBed;
    import interactive.apartment.props.bedroom.Lightswitch;

    import bluekarma.interactive.base.InteractionObject;

    import levels.abstract.AbstractLevel;

    import navigation.PositionArrow;

    import settings.backgrounds.BackgroundRileysApartment;
    import settings.backgrounds.BackgroundSlumsAlley;
    import settings.foregrounds.ForegroundRileysApartment;
    import settings.foregrounds.slums_street.ForegroundSlumsStreet;
    import settings.foregrounds.Overlay;

    import helpers.GameClock;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.Texture;
    import starling.display.Quad;

    import players.Player;

    //flash classes
    import flash.geom.Point;
    import flash.utils.describeType;
    import flash.globalization.DateTimeFormatter;

    //import all assets
    import bluekarma.assets.sound.SoundAssets;

    import assets.CharacterDialogueAssets;
    import assets.Level1Assets;

    import helpers.GameClock;

    import starling.events.TouchProcessor;

    //import level background
    import settings.backgrounds.BackgroundSlumsStreet;

    //import states
    import states.Level1State;

    //import player class
    import players.Player;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AbstractRileysApartment extends AbstractLevel
    {
        //this is the street background (spans 3 screens)
        protected var _apartmentBg:BackgroundRileysApartment;
        //foreground
        protected var _apartmentFg:ForegroundRileysApartment;
        //Navigation Arrows
        protected var _arrow1:PositionArrow;
        protected var _arrow2:PositionArrow;
        protected var _arrow3:PositionArrow;
        protected var _arrow4:PositionArrow;
        protected var _arrow5:PositionArrow;
        //Apartment Attributes
        protected var _clock:Date = new Date(2013, 0, 0, 19, 20, 0);
        /**
         * @desc determines what time of the day for lighting (dark, lights, daylight)
         */
        protected var _timeOfDay:String;

        override protected function drawLevel():void
        {
            this._backgroundPosition = 1;
            addBackground();
            addForeground();
            addNavigationArrows(_apartmentBg.numChildren);
            addInventory();
            addListeners();
        }

        override protected function addBackground():void
        {
            _apartmentBg = new BackgroundRileysApartment(this._backgroundPosition);
            _apartmentBg.x = 0;
            _apartmentBg.y = 0;
            addChild(_apartmentBg);
        }

        override protected function addForeground():void
        {
            _apartmentFg = new ForegroundRileysApartment(this._backgroundPosition);
            _apartmentFg.x = 0;
            _apartmentFg.y = 0;
            addChild(_apartmentFg);
            _apartmentFg.turnOffBedroomLights();
        }

        override protected function createNavigationArrows():void
        {
            _arrow1 = new PositionArrow("arrow1", true);
            _arrow1.setRotation(_arrow1.DIRECTION_RIGHT);
            _arrow1.scaleX = 0.5;
            _arrow1.x = 948;
            _arrow1.y = 725;
            _arrow2 = new PositionArrow("arrow2", true);
            _arrow2.setRotation(_arrow2.DIRECTION_LEFT);
            _arrow2.scaleX = 0.5;
            _arrow2.x = 1102;
            _arrow2.y = 725;
            _arrow3 = new PositionArrow("arrow3", true);
            _arrow3.setRotation(_arrow3.DIRECTION_DOWN);
            _arrow3.scaleY = 0.5;
            _arrow3.x = 1530;
            _arrow3.y = 735;
            _arrow4 = new PositionArrow("arrow4", true);
            _arrow4.setRotation(_arrow4.DIRECTION_RIGHT);
            _arrow4.scaleX = 0.5;
            _arrow4.x = 1978;
            _arrow4.y = 725;
            _arrow5 = new PositionArrow("arrow5", true);
            _arrow5.setRotation(_arrow5.DIRECTION_LEFT);
            _arrow5.scaleX = 0.5;
            _arrow5.x = 2130;
            _arrow5.y = 725;
        }

        override protected function addNavigationArrows(indexVal:uint = 0):void
        {

            //instantiate and place navigation arrows
            createNavigationArrows();
            _arrow1.setSourceDestination(1, 2);
            _arrow2.setSourceDestination(2, 1);
            _arrow4.setSourceDestination(2, 3);
            _arrow5.setSourceDestination(3, 2);
            _arrow1.setPlayerTargetDestinationPoint(0, 355);
            _arrow2.setPlayerTargetDestinationPoint(1024, 355);
            _arrow4.setPlayerTargetDestinationPoint(0, 355);
            _arrow5.setPlayerTargetDestinationPoint(1024, 355);
            //add to stage
            _apartmentBg.addChildAt(_arrow1, indexVal);
            _apartmentBg.addChildAt(_arrow2, indexVal);
            _apartmentBg.addChildAt(_arrow3, indexVal);
            _apartmentBg.addChildAt(_arrow4, indexVal);
            _apartmentBg.addChildAt(_arrow5, indexVal);
        }

        /**
         * set the walking boundaries for the player
         */

        override protected function setWalkingBoundaries(debug:Boolean = false):void
        {
            switch (_backgroundPosition) {
                case 1:
                    _walkBoundaryUp = 633;
                    _walkBoundaryDown = 760;
                    _walkBoundaryLeft = 249;
                    _walkBoundaryRight = 1024;
                    break;
                case 2:
                    _walkBoundaryUp = 650;
                    _walkBoundaryDown = 768;
                    _walkBoundaryLeft = 0;
                    _walkBoundaryRight = 1024;
                    break;
                case 3:
                    _walkBoundaryUp = 650;
                    _walkBoundaryDown = 765;
                    _walkBoundaryLeft = 0;
                    _walkBoundaryRight = 700;
                    break;
            }
            trace("walk boundaries are:", _walkBoundaryUp, _walkBoundaryDown, _walkBoundaryLeft, _walkBoundaryRight);
        }

        public function setBackgroundAndForegroundTest(position:uint):void
        {
            _backgroundPosition = position;
            addBackground();
            addForeground();
            //_apartmentFg.turnOnBedroomLights();
            //_apartmentFg.turnOnKitchenLights();
            _apartmentBg.setCurrentPosition(position);
            _apartmentFg.setCurrentPosition(position);
        }

        protected function addListeners():void
        {
            //added listener to check for light change from switch
            trace("added listener from FG for lighting toggle");
            this.addEventListener("lightSwitchToggle", toggleLighting);
        }

        protected function setBackgroundAndForeground(position:uint):void
        {
            _backgroundPosition = position;
            _apartmentBg.setCurrentPosition(position);
            _apartmentFg.setCurrentPosition(position);
        }

        private function toggleLighting(e:Event):void
        {
            trace(" IN TOGGLE LIGHTING AT SUPERCLASS");
            _apartmentFg.toggleLighting();
        }
    }
}
