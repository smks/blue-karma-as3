package dialogue.phone.components
{
    import starling.core.Starling;
    import starling.display.Image;

    import assets.PhoneDialogueAssets;

    import starling.display.Sprite;

    /**
     * ...
     * @author Shaun Stone
     */
    public class PhoneReception extends Sprite
    {
        /**
         * options of reception images available
         */
        public static const POOR:String = "poor";
        public static const AVERAGE:String = "average";
        public static const GOOD:String = "good";
        protected var _currentReception:String;
        protected var _poorSignal:Image;
        protected var _avgSignal:Image;
        protected var _goodSignal:Image;

        public function PhoneReception(reception:String)
        {
            _currentReception = reception;
            drawReception();
        }

        public function setReceptionPoor():void
        {
            _poorSignal.visible = true;
            _avgSignal.visible = false;
            _goodSignal.visible = false;
        }

        public function setReceptionAverage():void
        {
            _poorSignal.visible = false;
            _avgSignal.visible = true;
            _goodSignal.visible = false;
        }

        public function setReceptionGood():void
        {
            _poorSignal.visible = false;
            _avgSignal.visible = false;
            _goodSignal.visible = true;
        }

        private function drawReception():void
        {
            _poorSignal = new Image(PhoneDialogueAssets.getAtlas().getTexture(POOR));
            _avgSignal = new Image(PhoneDialogueAssets.getAtlas().getTexture(AVERAGE));
            _goodSignal = new Image(PhoneDialogueAssets.getAtlas().getTexture(GOOD));
            setCurrentReception(_currentReception);
            addChild(_poorSignal);
            addChild(_avgSignal);
            addChild(_goodSignal);
        }

        private function setCurrentReception(reception:String):void
        {
            _currentReception = reception;
            switch (_currentReception) {
                case POOR:
                    setReceptionPoor();
                    break;
                case AVERAGE:
                    setReceptionAverage();
                    break;
                case GOOD:
                    setReceptionGood();
                    break;
            }
        }
    }
}