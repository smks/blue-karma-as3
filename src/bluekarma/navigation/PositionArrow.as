package navigation
{
    import interfaces.INavigation;

    import mx.core.ButtonAsset;

    import starling.display.Button;
    import starling.display.Sprite;

    import assets.GameAssets;

    import starling.utils.deg2rad;
    import starling.events.Event;

    import states.GameState;

    import assets.NavigationAssets;

    import starling.display.Image;

    import flash.geom.Point;

    import starling.display.DisplayObject;

    /**
     * ...
     * @author Shaun Stone
     */
    public class PositionArrow extends AbstractNavigation implements INavigation
    {
        //arrow is up by default
        protected const ARROW:String = "ArrowGameButtonUp";
        protected var _source:uint = 0;
        protected var _destination:uint = 0;
        protected var _playerTargetXPoint:int = 0;
        protected var _playerTargetYPoint:int = 0;

        /**
         *
         * @param    id
         * @param    active
         * @param    direction
         * @desc    pass in an unique id, whether it should be active and what direction it
         *            will be facing
         */
        public function PositionArrow(id:String, active:Boolean)
        {
            super(id, active);
        }

        override protected function drawNavigation():void
        {
            _object = new Image(NavigationAssets.getTexture(ARROW));
            _object.pivotX = (_object.width / 2)
            _object.pivotY = (_object.height / 2)
            addChild(_object);
            if (_active) {
                setActive();
            }
        }

        public override function hitTest(localPoint:Point, forTouch:Boolean = false):DisplayObject
        {
            var target:DisplayObject = super.hitTest(localPoint, forTouch);
            return (forTouch && target != null ? this : target);
        }

        /**
         *
         * @param    xPos
         * @param    yPos
         * @desc    this allows the player to know what position he will be placed
         *            when the arrow has been touched/clicked
         */
        public function setPlayerTargetDestinationPoint(xPos:int, yPos:int):void
        {
            this._playerTargetXPoint = xPos;
            this._playerTargetYPoint = yPos;
        }

        /**
         *
         * @param    source
         * @param    destination
         * @return void
         */

        public function setSourceDestination(source:uint, destination:uint):void
        {
            this._source = source;
            this._destination = destination;
        }

        public function getSource():uint
        {
            return _source;
        }

        public function getDestination():uint
        {
            return _destination;
        }

        public function getTargetXPoint():int
        {
            return _playerTargetXPoint;
        }

        public function getTargetYPoint():int
        {
            return _playerTargetYPoint;
        }
    }
}