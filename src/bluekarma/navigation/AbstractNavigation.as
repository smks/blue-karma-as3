package navigation
{
    import flash.geom.Point;

    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Sprite;

    import interfaces.INavigation;

    import starling.events.Event;
    import starling.utils.deg2rad;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AbstractNavigation extends Sprite implements INavigation
    {
        public const DIRECTION_UP:String = "up";
        public const DIRECTION_DOWN:String = "down";
        public const DIRECTION_RIGHT:String = "right";
        public const DIRECTION_LEFT:String = "left";
        protected var _id:String;
        protected var _object:Image;
        protected var _active:Boolean = false;
        protected var _direction:String;

        public function AbstractNavigation(id:String, active:Boolean)
        {
            this._id = id;
            this._active = active;
            this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public override function hitTest(localPoint:Point, forTouch:Boolean = false):DisplayObject
        {
            var target:DisplayObject = super.hitTest(localPoint, forTouch);
            return (forTouch && target != null ? this : target);
        }

        public function setRotation(direction:String):void
        {
            //arrows start up by default
            switch (direction) {
                case DIRECTION_UP:
                    this.rotation = deg2rad(0);
                    break;
                case DIRECTION_RIGHT:
                    this.rotation = deg2rad(90);
                    break;
                case DIRECTION_DOWN:
                    this.rotation = deg2rad(180);
                    break;
                case DIRECTION_LEFT:
                    this.rotation = deg2rad(270);
                    break;
            }
            this._direction = direction;
        }

        public function setActive():void
        {
            this.touchable = true;
            this.alpha = 0.5;
        }

        /* INTERFACE interfaces.INavigation */
        public function setInactive():void
        {
            this.touchable = false;
            this.alpha = 0.1;
        }

        public function getDirection():String
        {
            return _direction;
        }

        public function getId():String
        {
            return _id;
        }

        public function setId(value:String):void
        {
            _id = value;
        }

        protected function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawNavigation();
        }

        protected function drawNavigation():void
        {
        }
    }
}