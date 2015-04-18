package interactive.backalley.props
{
    import assets.BackAlleyAssets;
	import sound.SoundManager;

    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.interactive.base.InteractionRepoFactory;

    import com.greensock.TweenLite;

    import flash.events.Event;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;

    import interactive.base.Prop;

    import starling.animation.Transitions;
    import starling.animation.Tween;
    import starling.core.Starling;
    import starling.display.Image;
    import starling.utils.deg2rad;

    /**
     * Interactive Prop: Fan
     * @author Shaun Stone
     * Created at: 30-11-2014 18:19:57
     */
    public class Fan extends Prop
    {
        /**
         * The image retrieved from Assets
         */
        private var image:Image;
        private var blades:Image;
        private var bladeCenter:Image;
        private var isSpinning:Boolean = false;
        /*
         * Main Constructor, override any default properties here
         */
        public function Fan(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
            setExaminable(true);
        }

        /**
         * Retrieve Image from assets then draw the prop
         *
         */
        override protected function getPropAsset(id:String):void
        {
            image = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.FAN));
            image.scaleX = 1;
            image.scaleY = 1;
            addChild(image);
            blades = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.FAN_BLADES));
            blades.pivotY = blades.height / 2;
            blades.pivotX = blades.width / 2;
            blades.x = 135.5;
            blades.y = 129.5;
            addChild(blades);
            bladeCenter = new Image(
				BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.FAN_BLADE_CENTER)
			);
            bladeCenter.x = 126;
            bladeCenter.y = 119;
            addChild(bladeCenter);
        }

        /**
         * Choose the repo to retrieve the prop from
         */
        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.BACK_ALLEY;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject();
        }

        /**
         * When TriggerExamine is called, we may want to do
         * something other than what's expected for the prop
         * @param params - pass in parameters we may want to use
         */
        override public function triggerExamine(params:Object = null):void
        {
            super.triggerExamine(params);
        }

        public function spin():void
        {
            setSpin(true);
            playFanGeneratorSound();
            animate();
            touchable = false;
        }
		
		public function turnOff():void
		{
			setSpin(false);
			stopFanGeneratorSound();
			animate();
			touchable = true;
		}

        /**
         * @return Boolean
         */
        public function setSpin(val:Boolean):void
        {
            this.isSpinning = val;
        }

        public function isOn():Boolean
        {
            return this.isSpinning;
        }

        public function isOff():Boolean
        {
            return !this.isSpinning;
        }

        private function animate():void
        {
            if (this.itShouldSpin()) {
                startAnimation();
            } else {
                startAnimation(false);
            }
        }

        /*
         * Override Trigger Interaction Object and create new behaviour for Item
         * @examples
         *  params.currentState - trigger an object dependent on the state of level
         *  params.playerPosition - x position to determine if player is near the object
         *  params.* pass in anything necessary
         */
        private function startAnimation(repeat:Boolean = true):void
        {
            var transition:String;
            var repeatCount:Number;
            if (repeat) {
                transition = Transitions.LINEAR;
                repeatCount = Number.MAX_VALUE;
            } else {
                transition = Transitions.EASE_OUT;
                repeatCount = 1;
            }
            var tween:Tween = new Tween(blades, 1.0, transition);
            tween.repeatCount = repeatCount;
            tween.animate("rotation", deg2rad(360));
            Starling.juggler.add(tween);
        }

        private function playFanGeneratorSound():void
        {
		   SoundManager.addSound("fan-generator", SoundAssets.fanGenerator, int.MAX_VALUE, 0);
		   SoundManager.fadeIn("fan-generator");
        }
		
		public function stopFanGeneratorSound():void
		{
			SoundManager.fadeOutAndRemove("fan-generator");
		}

        /**
         * @return Boolean
         */
        private function itShouldSpin():Boolean
        {
            return this.isSpinning;
        }
    }
}