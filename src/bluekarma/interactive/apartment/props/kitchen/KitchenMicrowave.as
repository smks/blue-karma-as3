package interactive.apartment.props.kitchen
{
    import bluekarma.assets.sound.SoundAssets;

    import flash.events.Event;
    import flash.media.Sound;
    import flash.media.SoundChannel;

    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    import flash.media.SoundTransform;

    /**
     * ...
     * @author Shaun Stone
     */
    public class KitchenMicrowave extends Prop
    {
        private const OFF:uint = 1;
        private const ON:uint = 2;
        private const READY:uint = 3;
        private const OPEN:uint = 4;
        private var microwaveOn:Image;
        private var microwaveOff:Image;
        private var microwaveReady:Image;
        // By default microwave is closed and off
        private var microwaveState:uint = 1;

        public function KitchenMicrowave(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var microwaveOffName:String = RileyApartmentAssets.KITCHEN_MICROWAVE_OFF;
            var microwaveOnName:String = RileyApartmentAssets.KITCHEN_MICROWAVE_RUNNING;
            var microwaveReadyName:String = RileyApartmentAssets.KITCHEN_MICROWAVE_FINISHED;
            microwaveOff = new Image(RileyApartmentAssets.getAtlas().getTexture(microwaveOffName));
            microwaveOn = new Image(RileyApartmentAssets.getAtlas().getTexture(microwaveOnName));
            microwaveReady = new Image(RileyApartmentAssets.getAtlas().getTexture(microwaveReadyName));
            microwaveOn.visible = false;
            microwaveReady.visible = false;
            //add to stage
            addChild(microwaveOff);
            addChild(microwaveOn);
            addChild(microwaveReady);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            switch (microwaveState) {
                case OFF:
                    turnOn();
                    break;
                case ON:
                    turnOff();
                    break;
                case READY:
                    turnOff();
                    break;
                case OPEN:
                    close();
                    break;
                default:
                    return;
            }
        }

        public function open():void
        {
            SoundAssets.kitchenMicrowaveOpen.play();
        }

        public function close():void
        {
            SoundAssets.kitchenMicrowaveClose.play();
        }

        public function turnOn():void
        {
            setCurrentState(2);
            var sound:Sound = SoundAssets.kitchenMicrowaveRunning;
            var soundCh:SoundChannel = new SoundChannel();
            soundCh = sound.play();
            soundCh.addEventListener(Event.SOUND_COMPLETE, whenMicrowaveHasFinished);
            microwaveOn.visible = true;
            microwaveReady.visible = false;
            microwaveOff.visible = false;
        }

        public function turnOff():void
        {
            microwaveOn.visible = false;
            microwaveReady.visible = false;
            microwaveOff.visible = true;
        }

        public function setReady():void
        {
            microwaveOn.visible = false;
            microwaveReady.visible = true;
            microwaveOff.visible = false;
        }

        private function setCurrentState(number:Number):void
        {
            microwaveState = number;
        }

        private function whenMicrowaveHasFinished(e:Event):void
        {
            SoundAssets.kitchenMicrowaveBeep.play();
            setCurrentState(1);
            turnOff();
        }
    }
}