package interactive.apartment.props.bedroom
{
    import assets.RileyApartmentAssets;

    import com.greensock.loading.data.ImageLoaderVars;

    import flash.events.TimerEvent;
    import flash.media.SoundChannel;
    import flash.utils.Timer;

    import interactive.base.Prop;

    import starling.display.Image;

    import bluekarma.assets.sound.SoundAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class MobilePhone extends Prop
    {
        protected var _phoneAnswered:Boolean = false;
        protected var _mobileOff:Image;
        protected var _mobileOn:Image;
        protected var _ringingTimer:Timer;
        protected var _phoneLit:Boolean = false;
        protected var _soundChannel:SoundChannel;

        public function MobilePhone(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var _mobileOffName:String = RileyApartmentAssets.BEDROOM_MOBILE_OFF;
            var _mobileOnName:String = RileyApartmentAssets.BEDROOM_MOBILE_ON;
            _mobileOff = new Image(RileyApartmentAssets.getAtlas().getTexture(_mobileOffName));
            _mobileOn = new Image(RileyApartmentAssets.getAtlas().getTexture(_mobileOnName));
            _mobileOn.x = -7;
            _mobileOn.y = -27;
            //show off by default
            turnOff();
            addChild(_mobileOn);
            addChild(_mobileOff);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            trace("triggered phone");
        }

        public function ringMobile():void
        {
            //ensure sound channel exists
            createSoundChannel();
            //play ringing sound
            _soundChannel = SoundAssets.apartmentMobilePhoneRinging.play(0, 100);
            //set mobiel off by default
            _mobileOff.visible = false;
            _ringingTimer = new Timer(2200, Number.MAX_VALUE);
            _ringingTimer.addEventListener(TimerEvent.TIMER, toggleMobileLight);
            _ringingTimer.start();
            //show phone light
            turnOn();
        }

        public function stopRingingMobile():void
        {
            if (_soundChannel) {
                _soundChannel.stop();
            }
        }

        public function turnOn():void
        {
            _mobileOff.visible = false;
            _mobileOn.visible = true;
            setPhoneLit(true);
        }

        public function turnOff():void
        {
            _mobileOff.visible = true;
            _mobileOn.visible = false;
            setPhoneLit(false);
        }

        public function setPhoneAnswered(val:Boolean):void
        {
            _phoneAnswered = val;
        }

        public function getPhoneAnswered():Boolean
        {
            return _phoneAnswered;
        }

        public function getPhoneLit():Boolean
        {
            return _phoneLit;
        }

        private function createSoundChannel():void
        {
            if (_soundChannel == null) {
                var _soundChannel:SoundChannel = new SoundChannel();
            }
        }

        private function toggleMobileLight(e:TimerEvent):void
        {
            if (_phoneLit) {
                turnOff();
            } else {
                turnOn();
            }
        }

        /**
         *
         * @param    lit
         */
        private function setPhoneLit(val:Boolean = true):void
        {
            _phoneLit = val;
        }
    }
}