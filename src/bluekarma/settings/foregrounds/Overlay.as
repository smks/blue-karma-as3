package settings.foregrounds
{
    import com.greensock.TweenLite;

    import flash.geom.Point;

    import settings.AbstractSetting;

    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.display.Button;

    import assets.GameAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class Overlay extends AbstractSetting
    {
        private const TRANSITION_SPEED:Number = 0.3;
        private var _overlay:Quad;
        private var _transparency:Number;

        public function Overlay(position:uint = 1, transparency:Number = 0.50)
        {
            _transparency = transparency;
            super(position);
        }

        override protected function composeSetting():void
        {
            drawSetting();
        }

        override protected function drawSetting():void
        {
            _overlay = new Quad(Game.STAGE_WIDTH, Game.STAGE_HEIGHT, 0x000000);
            _overlay.alpha = 0;
            addChild(_overlay);
            TweenLite.to(_overlay, TRANSITION_SPEED, {alpha: _transparency});
        }

        /**
         *
         * @param    localPoint
         * @param    forTouch
         * @return
         */

        public override function hitTest(localPoint:Point, forTouch:Boolean = false):DisplayObject
        {
            var target:DisplayObject = super.hitTest(localPoint, forTouch);
            return (forTouch && target != null ? this : target);
        }

        public function removeOverlay():void
        {
            TweenLite.to(_overlay, TRANSITION_SPEED, {alpha: 0, onComplete: remove});
        }

        private function remove():void
        {
            if (_overlay.alpha === 0) {
                removeFromParent(true);
            }
        }
    }
}