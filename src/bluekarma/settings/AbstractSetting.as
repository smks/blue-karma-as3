package settings
{
    import assets.RileyApartmentAssets;

    import bluekarma.interactive.base.Item;

    import com.greensock.loading.data.ImageLoaderVars;

    import interfaces.ISetting;

    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.display.Image;

    import assets.Level1Assets;
    import assets.Level1CharacterAssets;

    import bluekarma.assets.sound.SoundAssets;

    import starling.core.Starling;
    import starling.display.Button;

    import events.InteractionEvent;

    import flash.geom.Point;

    import starling.display.DisplayObject;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AbstractSetting extends Sprite implements ISetting
    {
        protected const STAGE_WIDTH:uint = 1024;
        protected const STAGE_HEIGHT:uint = 768;
        protected var _backgroundName:String;
        protected var _currentPosition:uint;

        /**
         *
         * @param    pos
         */
        public function AbstractSetting(position:uint = 1)
        {
            _currentPosition = position;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        /**
         *
         * @return
         */
        public function getCurrentPosition():uint
        {
            return _currentPosition;
        }

        /**
         *
         * @param    pos
         */
        public function setCurrentPosition(position:uint):void
        {
            //assign new position
            _currentPosition = position;
            //set position of background
            switch (_currentPosition) {
                case 1 :
                    this.x = 0;
                    this.y = 0;
                    break;
                case 2 :
                    this.x = -STAGE_WIDTH;
                    this.y = 0;
                    break;
                case 3 :
                    this.x = -(STAGE_WIDTH * 2);
                    this.y = 0;
                    break;
                case 4 :
                    this.x = 0;
                    this.y = -STAGE_HEIGHT;
                    break;
                case 5 :
                    this.x = -STAGE_WIDTH;
                    this.y = -STAGE_HEIGHT;
                    break;
                case 6 :
                    this.x = -(STAGE_WIDTH * 2);
                    this.y = -STAGE_HEIGHT;
                    break;
                default :
                    throw new Error('The position provided was not valid');
            }
        }

        /**
         *
         * @param    e
         */
        protected function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            composeSetting();
        }

        /**
         * @desc composes the level (draws, listeners etc.)
         */
        protected function composeSetting():void
        {
            trace("compose");
        }

        /**
         * renders the graphics
         */
        protected function drawSetting():void
        {
            trace("draw");
        }
    }
}