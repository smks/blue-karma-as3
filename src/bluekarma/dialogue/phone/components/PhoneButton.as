package dialogue.phone.components
{
    import starling.display.Sprite;
    import starling.core.Starling;
    import starling.display.Button;
    import starling.display.Image;

    import assets.PhoneDialogueAssets;

    import starling.events.Event;

    /**
     * ...
     * @author Shaun Stone
     */
    public class PhoneButton extends Sprite
    {
        /**
         * options of buttons available
         */
        public static const MUTE:String = "mute";
        public static const LOUDSPEAKER:String = "loudspeaker";
        public static const ANSWER:String = "answer";
        public static const END_CALL:String = "endcall";
        // alpha of disabled buttons
        public static const DISABLED:Number = 0.5;
        public static const ENABLED:uint = 1;
        protected var _name:String;
        protected var _disabled:Boolean;
        protected var _button:Button;

        public function PhoneButton(name:String, disabled:Boolean = false)
        {
            _name = name;
            _disabled = disabled;
            createButton();
        }

        public function disableButton():void
        {
            this.alpha = DISABLED;
            this.touchable = false;
        }

        public function enableButton():void
        {
            this.alpha = ENABLED;
            this.touchable = true;
        }

        private function createButton():void
        {
            _button = new Button(PhoneDialogueAssets.getAtlas().getTexture(_name));
            _button.addEventListener(Event.TRIGGERED, callButtonAction);
            addChild(_button);
            if (_disabled) {
                disableButton();
            }
        }

        private function callButtonAction(e:Event):void
        {
            dispatchEventWith("phoneButtonTriggered", true, _name);
        }
    }
}