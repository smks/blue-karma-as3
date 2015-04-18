package gui.inventory
{
    import adobe.utils.CustomActions;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import flexunit.flexui.data.FilterTestsModel;

    import global.Global;

    import levels.abstract.AbstractLevel;

    import notifications.modal.Modal;

    import bluekarma.interactive.base.Item;
    import bluekarma.components.conditions.ECG;

    import com.greensock.easing.Expo;
    import com.greensock.easing.Quint;

    import flash.media.Sound;
    import flash.utils.Dictionary;

    import interfaces.IInventory;

    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.display.Button;
    import starling.text.TextField;

    import assets.InventoryAssets;

    import states.GameState;

    import bluekarma.assets.sound.SoundAssets;

    import events.ItemEvent;

    import assets.IconAssets;

    import com.greensock.TweenLite;

    import flash.geom.Point;

    import starling.display.DisplayObject;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AbstractInventory extends Sprite implements IInventory
    {
        protected const POSITIION_1_X:uint = 626;
        // x positions of items
        protected const POSITIION_2_X:uint = 726;
        protected const POSITIION_3_X:uint = 826;
        protected const POSITIION_4_X:uint = 926;
        public const STATE_FINE:String = "fine";
        public const STATE_WORRIED:String = "uneasy";
        public const STATE_TERRIFIED:String = "terrified";
        protected const POSITIION_Y:uint = 5;
        protected var actContext:AbstractLevel;
        protected var menuAvailable:Boolean;
        protected var menuScrollSpeed:uint = 30;
        protected var easingSpeed:Number = 0.6;
        //background
        protected var inventoryBg:Image;
        //images
        protected var inventoryProfilePicRiley:Image;
        //buttons
        protected var inventory_action_combine:Button;
        protected var inventoryActionExamine:Button;
        protected var inventoryActionMobile:Button;
        protected var inventoryActionHint:Button;
        //text
        protected var playerNameBg:Quad;
        protected var playerNameText:TextField;
        //topggle minimise and maxmise
        protected var inventoryMaximise:Button;
        protected var inventoryMinimise:Button;
        //add menus
        protected var phoneMenu:PhoneMenu;
        protected var ecg:ECG;
        //dictionary of items
        protected var itemCollection:Dictionary;
        //id of item in focus
        protected var itemInFocus:String;
        protected var validator:Validator;
        protected var canShowHint:Boolean = true;

        public function AbstractInventory(actContext:AbstractLevel, debug:Boolean = false)
        {
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
            this.actContext = actContext;
        }
		
		protected function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            //crate dictionary to hold objects
            if (itemCollection === null) {
                itemCollection = new Dictionary();
            }
            //draw inventory
            drawInventory();
            addValidator();
            //add mobile dashboard
            //addMobileDashboard() - needs to be done by level - to set params
            //add event listeners
            addListeners();
        }

        public function loseItemFocus():void
        {
            if (itemInFocus) {
                itemCollection[itemInFocus].deselectItem();
            }
        }

        public function getItemInFocus():String
        {
            return itemInFocus;
        }

        public function addItem(item:Item):void
        {
            if (itemCollection === null) {
                throw new Error("Item collection can not be null");
            }
			
			if (itemCollection[item._id] !== undefined) {
				trace("item has already been added");
			}
			
            // let item know it is now in inventory
            item.setInInventory(true);
            // make sure item is not glowing for visibility
            item.setGlow(false);
            // deselect item if it is selected
            item.deselectItem();
            // change image for inventory if applicable
            item.changeItemImage(true);
            //check if item exists in inventory already
            if (item in itemCollection) {
                trace("item is in array");
            }
            else {
                //add item to inventory collection
                itemCollection[item._id] = item;
                itemCollection[item._id].scaleX = 1;
                itemCollection[item._id].scaleY = 1;
                itemCollection[item._id].alpha = 0;
                addChild(itemCollection[item._id]);
            }
            trace("adding item to inventory #################");
            trace(item + " has been added to inventory");
            updateItemPositions();
            organiseLayering();
        }

        public function removeItem(itemId:String):Boolean
        {
			if (itemCollection[itemId] === undefined) {
				trace("Item " + itemId + " does not not exist in Inventory");
				return true;
			}

            // ensure item is not set in inventoryu
            itemCollection[itemId].setInInventory(false);
            // ensure item is deselected
            itemCollection[itemId].deselectItem();
            // remove the object
            removeChild(itemCollection[itemId], true);
            // delete from the dictionary
            if (delete itemCollection[itemId]) {
                updateItemPositions();
                checkIfItemIsInFocus(itemId);
                return true;
            }
            return false;
        }

        public function setECGState(state:String):void
        {
            if (phoneMenu !== null) {
                phoneMenu.setCondition(state);
            }
            switch (state) {
                case STATE_FINE:
                    ecg.setConditionFine();
                    break;
                case STATE_WORRIED:
                    ecg.setConditionWorried();
                    break;
                case STATE_TERRIFIED:
                    ecg.setConditionTerrified();
                    break;
            }
        }

        public function minimiseInventory(e:Event):void
        {
            //minimise
            trace("minimising inventory");
            SoundAssets.buttonMinimiseBeep1.play();
            TweenLite.to(this, 0.8, {x: -Game.STAGE_WIDTH, ease: Quint.easeInOut});
        }

        public function maximiseInventory(e:Event):void
        {
            //maximise
            SoundAssets.buttonMaximiseBeep1.play();
            TweenLite.to(this, 0.8, {x: 0, ease: Quint.easeInOut});
            visible = true;
        }

        public function countItems():uint
        {
            var n:int = 0;
            for (var key:* in itemCollection) {
                n++;
            }
            return n;
        }

        public function hasItem(item:Item):Boolean
        {
            return Boolean(itemCollection[item._id]);
        }

        /**
         * @param id
         * @return Item
         */
        public function getItem(id:String):Item
        {
            return itemCollection[id];
        }

        public function closeMenu():void
        {
            SoundAssets.buttonMinimiseBeep1.play();
            TweenLite.to(this, 0.8, {x: -Game.STAGE_WIDTH, ease: Quint.easeInOut});
        }

        public function openMenu():void
        {
            SoundAssets.buttonMaximiseBeep1.play();
            TweenLite.to(this, 0.8, {x: 0, ease: Quint.easeInOut});
        }

        public function disableInventory():void
        {
            touchable = false;
            alpha = 0.8;
        }

        public function enableInventory():void
        {
            touchable = true;
            alpha = 1;
        }

        public function getPhoneMenu():PhoneMenu
        {
            return phoneMenu;
        }

        public function getCurrentTimeOnAct():Date
        {
            return getPhoneMenu().getCurrentTimeOnAct();
        }

        public function getActTimeDeadline():Date
        {
            return getPhoneMenu().getActTimeDeadline();
        }

        protected function addValidator():void
        {
            validator = new Validator();
        }

        protected function drawInventory():void
        {
            /* create minimise button */
            inventoryMinimise = new Button(InventoryAssets.getAtlas().getTexture("inventory_minimise"));
            inventoryMinimise.x = 1;
            addChild(inventoryMinimise);
            /* create background */
            inventoryBg = new Image(InventoryAssets.getAtlas().getTexture("inventory_bg"));
            inventoryBg.x = inventoryMinimise.width;
            addChild(inventoryBg);
            //create maxmimise button
            inventoryMaximise = new Button(InventoryAssets.getAtlas().getTexture("inventory_maximise"));
            inventoryMaximise.x = Game.STAGE_WIDTH - 2;
            addChild(inventoryMaximise);
            //create combine button
            inventoryActionExamine = new Button(InventoryAssets.getAtlas().getTexture("inventory_action_examine"));
            inventoryActionExamine.x = 532;
            inventoryActionExamine.y = 16;
            addChild(inventoryActionExamine);
            //create combine button
            inventoryActionHint = new Button(InventoryAssets.getAtlas().getTexture("inventory_action_hint"));
            inventoryActionHint.x = 427;
            inventoryActionHint.y = 10;
            addChild(inventoryActionHint);
            //create mobile button
            inventoryActionMobile = new Button(InventoryAssets.getAtlas().getTexture("inventory_action_mobile"));
            inventoryActionMobile.x = 343;
            inventoryActionMobile.y = 11;
            inventoryActionMobile.enabled = false;
            addChild(inventoryActionMobile);
            /* add images */
            inventoryProfilePicRiley = new Image(InventoryAssets.getAtlas().getTexture("inventory_profile_pic_riley"));
            inventoryProfilePicRiley.x = 114;
            inventoryProfilePicRiley.y = 4;
            addChild(inventoryProfilePicRiley);
            playerNameText = new TextField(95, 20, GameState.CURRENT_PLAYER, Global.DEFAULT_FONT, 13, Global.BLUE_KARMA_WHITE, true);
            playerNameText.x = 105;
            playerNameText.y = 80;
            addChild(playerNameText);
            ecg = new ECG();
            ecg.x = 199;
            ecg.y = 0;
            addChild(ecg);
            //hide inventory by default
            x = -Game.STAGE_WIDTH;
        }

        protected function addListeners():void
        {
            /* add event listeners */
            //maximise and minimise animations
            inventoryMaximise.addEventListener(Event.TRIGGERED, maximiseInventory);
            inventoryMinimise.addEventListener(Event.TRIGGERED, minimiseInventory);
            //mobile dashboard initiation
            inventoryActionMobile.addEventListener(Event.TRIGGERED, openMobileDashboard);
            //item manipulation buttons
            inventoryActionExamine.addEventListener(Event.TRIGGERED, examineItem);
            inventoryActionHint.addEventListener(Event.TRIGGERED, showHint);
            //listen for any items put in focus
            addEventListener("itemInFocus", dealWithItemFocus);
        }

        protected function updateItemPositions():void
        {
            var j:uint = 1;
            for (var i:Object in itemCollection) {
                trace(j);
                positionItem(itemCollection[i], j);
                TweenLite.to(itemCollection[i], 1, {alpha: 1});
                j++;
            }
        }

        protected function positionItem(item:Item, pos:uint):void
        {
            trace("positioning item", item);
            item.y = POSITIION_Y;
            switch (pos) {
                case 1:
                    trace("we have 1 item");
                    item.x = POSITIION_1_X;
                    break;
                case 2:
                    trace("we have 2 items");
                    item.x = POSITIION_2_X;
                    break;
                case 3:
                    trace("we have 3 item");
                    item.x = POSITIION_3_X;
                    break;
                case 4:
                    trace("we have 4 items");
                    item.x = POSITIION_4_X;
                    break;
                default:
                    throw new Error("no item positioning available");
            }
        }

        protected function showHint(e:Event):void
        {
            SoundAssets.buttonClick1.play();
            if (canShowHint === false) {
                return;
            }
            canShowHint = false;
            var i:uint;
            var reminder:String
            if (phoneMenu === null) {
                reminder = "No Hints Available";
            } else {
                reminder = phoneMenu.getLatestReminder();
                phoneMenu.removeLatestReminder();
            }
            var notify:Modal = new Modal(reminder, Modal.QUESTION_MARK);
            addChild(notify);
            var timer:Timer = new Timer(1000, 5);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, allowHint);
            timer.start();
        }

        protected function examineItem(e:Event):void
        {
            //examine item if exists otherwise create new dialogue
            SoundAssets.buttonClick1.play();
            if (itemCollection[itemInFocus] !== undefined) {
                if (itemCollection[itemInFocus]._examinable) {
                    itemCollection[itemInFocus].triggerExamine();
                }
            }
        }

        protected function openMobileDashboard(e:Event):void
        {
            if (phoneMenu == null) {
                return;
            }
            TweenLite.to(phoneMenu, 0.6, {y: 0, ease: Expo.easeInOut});
            //SoundAssets.buttonBeep1.play();
        }
		
		public function closeMobileDashboard():void
		{
			TweenLite.to(phoneMenu, 0.6, {y: Game.STAGE_HEIGHT, ease: Expo.easeInOut});
		}

        private function allowHint(e:TimerEvent):void
        {
            canShowHint = true;
        }

        private function dealWithItemFocus(e:Event):void
        {
            var focus:Boolean = e.data.focused;
            var itemId:String = e.data.item._id;
            if (focus) {

                // loop through other items and deselect as other is now focused
                for (var i:String in itemCollection) {
                    if (itemCollection[i].id !== itemId) {
                        if (itemCollection[i].isFocused()) {
                            itemCollection[i].deselectItem();
                        }
                    }
                }
                itemInFocus = itemId;
            }
            else {
                itemInFocus = null;
            }
            trace("current item in focus is", itemInFocus);
        }

        /**
         * Whenever an item is added it makes sure that the mobile menu always
         * shows above them
         */
        protected function organiseLayering():void
        {
            if (phoneMenu == null) {
                return;
            }
            setChildIndex(phoneMenu, numChildren);
        }

        private function checkIfItemIsInFocus(itemId:String):void
        {
            trace("called check if item is in focus");
            if (itemInFocus == itemId) {
                trace(itemInFocus);
                trace(itemId);
                itemInFocus = null;
            }
        }
    }
}