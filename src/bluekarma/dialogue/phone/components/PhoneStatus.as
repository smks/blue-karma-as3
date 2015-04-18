package dialogue.phone.components
{
    import assets.PhoneDialogueAssets;

    import starling.display.Image;
    import starling.display.Sprite;

    /**
     * ...
     * @author Shaun Stone
     */
    public class PhoneStatus extends Sprite
    {
        /**
         * options of reception images available
         */
        public static const CONNECTED:String = "connected";
        public static const CALLING:String = "calling";
        public static const DISCONNECTED:String = "disconnected";
        protected var _currentPhoneStatus:String;
        protected var _connected:Image;
        protected var _calling:Image;
        protected var _disconnected:Image;

        public function PhoneStatus(phoneStatus:String)
        {
            _currentPhoneStatus = phoneStatus;
            drawStatus();
        }

        public function setStatusConnected():void
        {
            _connected.visible = true;
            _calling.visible = false;
            _disconnected.visible = false;
        }

        public function setStatusCalling():void
        {
            _connected.visible = false;
            _calling.visible = true;
            _disconnected.visible = false;
        }

        public function setStatusDisconnected():void
        {
            _connected.visible = false;
            _calling.visible = false;
            _disconnected.visible = true;
        }

        private function drawStatus():void
        {
            _connected = new Image(PhoneDialogueAssets.getAtlas().getTexture(CONNECTED));
            _calling = new Image(PhoneDialogueAssets.getAtlas().getTexture(CALLING));
            _disconnected = new Image(PhoneDialogueAssets.getAtlas().getTexture(DISCONNECTED));
            setCurrentStatus(_currentPhoneStatus);
            addChild(_connected);
            addChild(_calling);
            addChild(_disconnected);
        }

        private function setCurrentStatus(status:String):void
        {
            _currentPhoneStatus = status;
            switch (_currentPhoneStatus) {
                case CONNECTED:
                    setStatusConnected();
                    break;
                case CALLING:
                    setStatusCalling();
                    break;
                case DISCONNECTED:
                    setStatusDisconnected();
                    break;
            }
        }
    }
}