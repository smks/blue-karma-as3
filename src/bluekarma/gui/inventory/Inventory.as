package gui.inventory
{
    import adobe.utils.CustomActions;
	import assets.settings.backgrounds.albertscar.moving.MovingBackgroundSlumsAssets;

    import levels.abstract.AbstractLevel;

    import bluekarma.interactive.general.items.Chip;

    import flash.geom.Point;
    import flash.media.Sound;
    import flash.utils.Dictionary;

    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.display.Button;
    import starling.text.TextField;

    import gui.inventory.AbstractInventory;

    import assets.InventoryAssets;

    import states.GameState;

    import bluekarma.assets.sound.SoundAssets;

    import events.ItemEvent;

    import assets.IconAssets;

    import com.greensock.TweenLite;

    /**
     * ...
     * @author Shaun Stone
     */
    public class Inventory extends AbstractInventory
    {
        private var chip:Chip;

        public function Inventory(actContext:AbstractLevel = null, debug:Boolean = false)
        {
            super(actContext, debug);
        }

        /**
         * @desc by default mobile menu is disabled
         *         unless this method is called and is
         *         passed params.
         * @param    params
         *
         * M - Mandatory
         * O - Optional
         *
         * params.act                - M
         * params.deviceOwner        - M
         * params.rfidNo             - M
         * params.leaderboardRank    - M
         * params.date                - M
         * params.apps                - O - Defaults to None
         * params.condition        - O - Defaults to fine
         * params.contacts            - O - Defaults to None
         *
         */
        public function addMobileDashboard(params:Object):void
        {
            if (validator.checkMandatoryPhoneMenuParams(params)) {
                if (phoneMenu == null) {
                    phoneMenu = new PhoneMenu(params);
                    phoneMenu.y = Game.STAGE_HEIGHT;
                    addChild(phoneMenu);
                    // make phone menu button interactive
                    inventoryActionMobile.enabled = true;
                } else {
                    throw new Error("phone menu instance exists already");
                }
            } else {
                throw new Error("tried to add mobile dashboard but not all mandatory params were provided");
            }
        }

        /**
         *
         * @param    id
         * @param    reminder
         * @param    priority
         */
        public function addReminder(id:String, reminder:String, priority:String = "fine"):void
        {
            if (phoneMenu == null) {
                throw new Error("adding reminder when phone menu hasn't been created yet");
            }
            phoneMenu.addReminder(id, reminder, priority);
        }

        /**
         * The chip will no doubt be part of every level act
         */
        public function addPlayerchip():void
        {
            if (chip === null) {
                chip = new Chip("chip", true);
                addChild(chip);
                this.addItem(chip);
            }
        }

        /**
         * Should we inform player they have reminders to read
         * @return bool
         */
        public function hasReminders():Boolean
        {
            return phoneMenu.hasReminders();
        }

        /**
         * We want to pass the items to the level parent class
         *
         * @return Dictionary
         */
        public function getItemCollection():Dictionary
        {
            if (itemCollection === null) {
                return itemCollection = new Dictionary();
            }
            return itemCollection;
        }

        /**
         *
         * @param dictionary
         */
        public function setItemCollection(dictionary:Dictionary, reAddItems:Boolean = true):void
        {
            this.itemCollection = null;
            this.itemCollection = dictionary;
            if (reAddItems) {
                for (var i:Object in itemCollection) {
                    itemCollection[i].setLevelItem(actContext.getLevelActName());
                    addChild(itemCollection[i]);
                }
            }
            updateItemPositions();
			organiseLayering();
			
        }

        public function hide():void
        {
            this.visible = false;
        }

        public function show():void
        {
            this.visible = true;
        }

        public function currentTimeOnClock():void
        {
            return
        }
		
		/**
		 * 
		 * @param name
		 * @param online
		 */
		public function addContact(id:String, name:String, online:Boolean):void 
		{
			phoneMenu.getContactMenu().addContact(id, name, online);
		}
    }
}