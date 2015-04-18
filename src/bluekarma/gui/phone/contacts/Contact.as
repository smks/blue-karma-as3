package gui.phone.contacts
{
    import assets.InventoryAssets;
	import global.Global;

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
    public class Contact extends Sprite
    {
        private const ONLINE:String = "phone-online";
        private const OFFLINE:String = "phone-offline";
        private const STATUS_X:uint = 245;
        private const STATUS_Y:uint = 16;
        private var _bar:Button;
        private var _id:String;
        private var _name:String;
        private var _nameText:TextField;
        private var _online:Boolean = false;
        private var _statusOnline:Image;
        private var _statusOffline:Image;

        public function Contact(id:String, name:String, online:Boolean)
        {
            _id = id;
            _name = name;
            _online = online;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function isOnline():Boolean
        {
            return _online;
        }

        public function setOnline():void
        {
            if (_online) {
                return;
            }
            _statusOnline.visible = true;
            _statusOffline.visible = false;
            _online = true;
        }

        public function setOffline():void
        {
            if (!_online) {
                return;
            }
            _statusOnline.visible = false;
            _statusOffline.visible = true;
            _online = false;
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawContact();
        }

        private function drawContact():void
        {
            // add bar
            var bar:Texture = InventoryAssets.getAtlas("mainMenu").getTexture("contact-bar");
            var barActive:Texture = InventoryAssets.getAtlas("mainMenu").getTexture("contact-bar-active");
            _bar = new Button(bar, "", barActive);
            _bar.downState
            addChild(_bar);
			
			_bar.addEventListener("triggered", makeACall);
			
            // add textfield of contact name
            _nameText = new TextField(200, 60, _name.toUpperCase(), Global.DEFAULT_FONT, 16, 0, true);
            _nameText.touchable = false;
            _nameText.hAlign = HAlign.LEFT;
            _nameText.x = 10;
            addChild(_nameText);
            _statusOnline = new Image(InventoryAssets.getAtlas("mainMenu").getTexture(ONLINE));
            _statusOnline.touchable = false;
            _statusOnline.x = STATUS_X;
            _statusOnline.y = STATUS_Y;
            _statusOnline.visible = false;
            addChild(_statusOnline);
            _statusOffline = new Image(InventoryAssets.getAtlas("mainMenu").getTexture(OFFLINE));
            _statusOffline.touchable = false;
            _statusOffline.x = STATUS_X;
            _statusOffline.y = STATUS_Y;
            _statusOffline.visible = false;
            addChild(_statusOffline);
            if (_online) {
                _statusOnline.visible = true;
            } else {
                _statusOffline.visible = true;
            }
        }
		
		private function makeACall(e:Event):void 
		{
			if (_online === true) {
				dispatchEventWith("MakeACallFromPhoneMenu", true, { id: _id } );
			}
		}
		
		public function getName():String
		{
			return _name;
		}
		
		public function getId():String 
		{
			return _id;
		}
    }
}