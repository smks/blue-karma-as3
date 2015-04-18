package gui.phone.contacts
{
    import adobe.utils.CustomActions;
	import assets.settings.backgrounds.albertscar.moving.MovingBackgroundSlumsAssets;

    import assets.GameAssets;
    import assets.InventoryAssets;
    import assets.MenuAssets;

    import com.greensock.easing.Expo;
    import com.greensock.TweenLite;

    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;

    /**
     * ...
     * @author Shaun Stone
     */
    public class ContactMenu extends Sprite
    {
        private const MAX_CONTACTS:uint = 11;
        private const TRANSITION_TIME:Number = 0.75;
        private const POSITION_Y_0:uint = 60;
        private const POSITION_0:uint = 60;
        private const POSITION_1:uint = 120;
        private const POSITION_2:uint = 180;
        private const POSITION_3:uint = 240;
        private const POSITION_4:uint = 300;
        private const POSITION_5:uint = 360;
        private const POSITION_6:uint = 420;
        private const POSITION_7:uint = 480;
        private const POSITION_8:uint = 540;
        private const POSITION_9:uint = 600;
        private const POSITION_10:uint = 660;
        private var bg:Image;
        private var closeBtn:Button;
        private var contactsList:Array;
        private var noContacts:TextField;
        private var debug:Boolean;

        public function ContactMenu(_contactsList:Array = null, _debug:Boolean = false)
        {
            trace("instance of contact menu");
            // will contain list of contacts
            contactsList = new Array();
            if (_contactsList !== null) {
                contactsList = _contactsList;
            }
            debug = _debug;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function addContact(id:String, name:String, online:Boolean):void
        {
            var contact:Contact = new Contact(id, name, online);
            contact.x = 15;
			
			var i:uint = getContactCount();
			contact.y = this["POSITION_" + i];
			
            contactsList.push(contact);
            addChild(contact);
			
			repositionContacts();
        }

        public function removeContact(id:String):void
        {
            var len:uint = countContacts();
            for (var i:uint = 0; i < len; i++) {
                if (contactsList[i].getId() == id) {
                    removeChild(contactsList[i]);
                    contactsList.splice(contactsList[i], 1);
                }
            }
			repositionContacts();
        }
		
		/**
		 * 
		 * @param name
		 * @param status
		 */
		public function setContactStatus(id:String, status:Boolean = true):void
		{
			contactsList.forEach(function(c:Contact, i:uint):void {
				if (c.getId() === id) {
					if (status === true) {
						c.setOnline();
					} else {
						c.setOffline();
					}
				}
			});
		}
		
		public function getContactCount():uint 
		{
			return contactsList.length;
		}

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawMenu();
            if (debug) {
                addDummyContacts();
            }
            initialise();
        }

        private function initialise():void
        {
            if (contactsList.length === 0) {
                noContacts = new TextField(200, 60, "No Contacts", "Verdana", 30, 0xffffff);
                noContacts.x = 60;
                noContacts.y = POSITION_1;
                addChild(noContacts);
            }
        }

        private function countContacts():uint
        {
            return contactsList.length;
        }

        private function addDummyContacts():void
        {
            for (var i:uint = 0; i < MAX_CONTACTS; i++) {
                var on:Boolean;
                (i % 2 == 0) ? on = true : on = false;
                var contact:Contact = new Contact(String("Id: " + i), String("Contact " + i), on);
                contact.x = 15;
                contact.y = this["POSITION_" + i];
                contactsList[i] = contact;
                addChild(contact);
            }
        }

        private function repositionContacts():void
        {
            var len:int = countContacts();
            if (len <= 0) {
                // show there is no contacts
                TweenLite.to(noContacts, TRANSITION_TIME, {alpha: 1});
            } else {
				TweenLite.to(noContacts, TRANSITION_TIME, {alpha: 0});
			}
            len--;
            for (var i:int = len; i >= 0; --i) {
                var yPos:uint = this["POSITION_" + i];
                trace("yPos s: ", yPos);
                TweenLite.to(contactsList[i], TRANSITION_TIME, {y: yPos});
                trace("element ", contactsList[i]);
            }
        }

        private function drawMenu():void
        {
            bg = new Image(InventoryAssets.getAtlas("mainMenu").getTexture("contact_menu_bg"));
            addChild(bg);
            closeBtn = new Button(GameAssets.getTexture("CloseButton"));
            closeBtn.width = 50;
            closeBtn.height = 50;
            closeBtn.x = 264;
            closeBtn.y = 6;
            addChild(closeBtn);
            closeBtn.addEventListener("triggered", closeContactMenu);
        }

        private function closeContactMenu(e:Event):void
        {
            // inform parent to remove overlay
            dispatchEventWith("closingSubMenu", true, {menu: "contacts"});
            TweenLite.to(this, 0.6, {x: Game.STAGE_WIDTH, ease: Expo.easeInOut});
        }
    }
}