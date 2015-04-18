package bluekarma.gui.phone.applications
{
    import assets.InventoryAssets;

    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.HAlign;

    /**
     * ...
     * @author ...
     */
    public class Application extends Sprite
    {
        public static const CAMERA:String = "camera";
        public static const MICROPHONE:String = "microphone";
        public static const VIDEO:String = "video";
        public static const SOCIAL:String = "social";
        public static const BANKING:String = "banking";
        private const MIDDLE_POINT:uint = 70;
        private var _tile:Button;
        private var _app:Image;
        private var _id:String;
        private var _enabled:Boolean = false;
        private var _statusOnline:Image;
        private var _statusOffline:Image;

        public function Application(id:String, enabled:Boolean = false)
        {
            _id = id;
            _enabled = enabled;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function setEnabled(val:Boolean):void
        {
            _tile.enabled = val;
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawContact();
        }

        private function drawContact():void
        {
            // add bar
            var tileTexture:Texture = InventoryAssets.getAtlas("mainMenu").getTexture("app_bg");
            var tileActiveTexture:Texture = InventoryAssets.getAtlas("mainMenu").getTexture("app_bg_active");
            _tile = new Button(tileTexture, "", tileActiveTexture);
            addChild(_tile);
            _app = new Image(getAppIcon());
            _app.touchable = false;
            _app.pivotX = _app.width / 2;
            _app.pivotY = _app.height / 2;
            _app.x = MIDDLE_POINT;
            _app.y = MIDDLE_POINT;
            addChild(_app);
            _tile.enabled = _enabled;
        }

        private function getAppIcon():Texture
        {
            if (_id === null) {
                throw new Error("id needed");
            }
            return InventoryAssets.getAtlas("mainMenu").getTexture(_id);
            ;
        }
    }
}