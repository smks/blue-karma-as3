package interactive.apartment.props.general
{
    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    import starling.display.MovieClip;

    /**
     * ...
     * @author Shaun Stone
     */
    public class Window extends Prop
    {
        public const LEFT:String = "left";
        public const RIGHT:String = "right";
        private var _window:MovieClip;
        private var _windowBlindsOpen:Image;
        private var _windowBlindsClosed:Image;
        private var _direction:String;

        public function Window(id:String, _examinable:Boolean = false, direction:String = LEFT)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            var windowName:String = RileyApartmentAssets.BEDROOM_WINDOW;
            var blindsOpen:String = RileyApartmentAssets.BEDROOM_BLINDS_OPEN;
            var blindsClosed:String = RileyApartmentAssets.BEDROOM_BLINDS_CLOSED;
            //create window
            _window = new MovieClip(RileyApartmentAssets.getAtlas().getTextures(windowName));
            _windowBlindsOpen = new Image(RileyApartmentAssets.getAtlas().getTexture(blindsOpen));
            _windowBlindsClosed = new Image(RileyApartmentAssets.getAtlas().getTexture(blindsClosed));
            _windowBlindsClosed.visible = false;
            if (_id == "kitchen_window") {
                this.scaleX = -1;
            }
            _windowBlindsClosed.x = -10;
            _windowBlindsOpen.x = -10;
            //add to stage
            addChild(_window);
            addChild(_windowBlindsOpen);
            addChild(_windowBlindsClosed);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }

        public function openBlinds():void
        {
            if (_windowBlindsOpen.visible = true) {
                return;
            }
            _windowBlindsOpen.visible = true;
            _windowBlindsClosed.visible = false;
        }

        public function closeBlinds():void
        {
            if (_windowBlindsClosed.visible = true) {
                return;
            }
            _windowBlindsOpen.visible = false;
            _windowBlindsClosed.visible = true;
        }
    }
}