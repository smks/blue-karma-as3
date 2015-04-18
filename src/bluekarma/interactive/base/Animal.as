package bluekarma.interactive.base
{
    import events.InteractionEvent;

    import flash.display.InteractiveObject;

    import bluekarma.interactive.base.InteractionObject;

    import interfaces.IAnimal;

    import starling.core.Starling;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;

    import assets.AnimalAssets;

    import bluekarma.assets.sound.SoundAssets;

    import starling.events.TouchEvent;
    import starling.events.Touch;
    import starling.events.TouchPhase;

    import flash.geom.Point;

    /**
     * ...
     * @author ...
     */
    public class Animal extends InteractionObject implements IAnimal
    {
        public var _object:MovieClip;

        /**
         *
         * @param    _id
         */
        public function Animal(id:String = "", examinable:Boolean = false)
        {
            if (id == "") {
                throw new Error("No ID assigned to the animal");
            }
            //fetch in type
            _id = id;
            _examinable = examinable;
            _type = "props";
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function sitDown():void
        {
        }

        public function standUp():void
        {
        }

        public function makeSound():void
        {
        }

        /**
         *
         * @param    e
         */

        protected function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawAnimal();
        }

        /**
         * @desc draw the animal
         */

        protected function drawAnimal():void
        {
        }

        /**
         *
         * @param    e
         */

        protected function onSoundComplete(e:Event):void
        {
            var wait:uint = getRandomNumber(1, 4);
            _object.setFrameDuration(1, wait);
        }
    }
}