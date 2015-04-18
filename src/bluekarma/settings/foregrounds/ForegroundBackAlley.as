package settings.foregrounds
{
    import assets.BackAlleyAssets;
    import assets.GameAssets;
    import assets.Level1Assets;

    import bluekarma.assets.settings.backgrounds.albertscar.AlbertJourneyAssets;

    import com.greensock.easing.Quart;
    import com.greensock.TweenLite;

    import settings.AbstractSetting;
    import settings.base.Foreground;

    import starling.display.BlendMode;
    import starling.display.Image;

    /**
     * ...
     * @author Shaun Stone
     */
    public class ForegroundBackAlley extends Foreground
    {
        private var _fg:Image;
        private var _ambienceSet:Boolean;
        private var filterFg:Image;
        private var binLeft:Image;
        private var binRight:Image;

        public function ForegroundBackAlley(position:uint = 1)
        {
            super(position);
            composeSetting();
        }

        override protected function composeSetting():void
        {
            drawSetting();
        }

        /**
         * renders the graphics
         */
        override protected function drawSetting():void
        {
            binLeft = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.FOREGROUND_BIN_LEFT));
            binLeft.x = 0;
            binLeft.y = 1149;
            addChild(binLeft);
            binRight = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.FOREGROUND_BIN_RIGHT));
            binRight.x = 895;
            binRight.y = 1149;
            addChild(binRight);
            // we don't want to tween this
            filterFg = new Image(GameAssets.getTexture("GradientOverlaySlums"));
			filterFg.scaleX = 4;
			filterFg.scaleY = 4;
            addChild(filterFg);
        }

        /**
         * Position will always be the same
         * @param    position
         */
        override public function setCurrentPosition(position:uint):void
        {
        }

        public function moveBinsToBottom():void
        {
        }

        /**
         *
         * @param yToBe
         */
        public function tweenPosition(yToBe:Number, time:Number = 0):void
        {
            tweenObject(binLeft, yToBe, time);
            tweenObject(binRight, yToBe, time);
        }

        /**
         *
         * @param object
         * @param yToBe
         * @param time
         */
        private function tweenObject(object:Image, yToBe:Number, time:Number = 0):void
        {
            if (yToBe < 0) {
                yToBe += ((Game.STAGE_HEIGHT * 2) - (binRight.height));
            } else {
                yToBe = Game.STAGE_HEIGHT * 2;
            }
            TweenLite.to(object, time, {
                y: yToBe,
                ease: Quart.easeInOut
            });
        }
    }
}