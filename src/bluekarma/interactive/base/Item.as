package bluekarma.interactive.base
{
    import assets.ItemAssets;

    import flash.media.Sound;

    import bluekarma.interactive.base.InteractionObject;

    import interfaces.IItem;

    import messages.Message;

    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;

    /**
     * ...
     * @author Shaun Stone
     *
     * Abstract class for items
     */
    public class Item extends InteractionObject implements IItem
    {
        //declare type of interaction object
        private static const TYPE:String = "items";
        //determines if the item is in the inventory
        protected var _inInventory:Boolean;
        //determines if item is currently in focus
        protected var _inFocus:Boolean;
        //asset for selected item hover
        protected var _selectedItemBg:Image;
        //check to see if item can be trashed
        protected var _trashable:Boolean = true;

        /**
         * Constructor
         *
         * @param    _name
         * @param    _talkable
         */

        public function Item(id:String, actionable:Boolean = false)
        {
            _id = id;
            _actionable = actionable;
            _type = Item.TYPE;
            setExaminable(true);
            setInInventory(false);
            setInFocus(false);
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            if (_actionable) {
                trace("item is pickable");
                if (_inInventory) {
                    trace("item is in inventory");
                    if (!_inFocus) {
                        trace("item is not in focus");
                        selectItem();
                    }
                    else {
                        trace("item is in focus");
                        deselectItem();
                    }
                }
            }
        }

        /**
         * No Items can be spoken to so return message "No"
         */
        override public function triggerChat(params:Object = null):void
        {
            var messageArray:Array = new Array();
            var voiceIdArray:Array = new Array();
            var voiceSounds:Array = new Array();
            messageArray = _repo.getThoughtId("no");
            voiceIdArray = _repo.getThoughtVoiceFile("no");
            var l:uint = voiceIdArray.length;
            for (var i:uint = 0; i < l; i++) {
                var voice:Sound = _repo.getVoiceFile(voiceIdArray[i]);
                voiceSounds[i] = voice;
            }
            dispatchEventWith("messageListener", true, {messages: messageArray[0], voices: voiceSounds});
        }

        /**
         * The image we show on the level may not be suitable
         * for the inventory (too long, wide) so we swap the image
         * with something more fitting
         * @param    inInventory
         */
        public function changeItemImage(inInventory:Boolean = true):void
        {
        }

        public function selectItem():void
        {
            if (!_inFocus) {
                showSelectedBackground();
                setInFocus(true);
                dispatchEventWith("itemInFocus", true, {item: this, focused: true});
            }
        }

        public function deselectItem():void
        {
            if (_inFocus) {
                hideSelectedBackground();
                setInFocus(false);
                dispatchEventWith("itemInFocus", true, {item: this, focused: false});
            }
        }

        public function isInInventory():Boolean
        {
            return _inInventory;
        }

        public function setInInventory(value:Boolean):void
        {
            _inInventory = value;
        }

        /**
         * If the item is currently focused
         * @return
         */
        public function isFocused():Boolean
        {
            return _inFocus;
        }

        public function setInFocus(value:Boolean):void
        {
            _inFocus = value;
        }

        public function isCombinable():Boolean
        {
            return _combinable;
        }

        public function setCombinable(value:Boolean):void
        {
            _combinable = value;
        }

        public function isTrashable():Boolean
        {
            return _trashable;
        }

        public function setTrashable(value:Boolean):void
        {
            _trashable = value;
        }

        /**
         * When added to the stage
         *
         * @param e
         */
        protected function onAdded(e:Event):void
        {
            //remove eventlistener added to stage
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            //This will show that item is in focus as an underlay
            createItemSelectionBackground();
            // Draw the item (Done in sub class)
            drawItem();
        }

        /**
         * Create Item Asset
         */
        protected function createItemSelectionBackground():void
        {
            _selectedItemBg = new Image(ItemAssets.getTexture("ItemSelected"));
            _selectedItemBg.x = -5;
            _selectedItemBg.y = -5;
            _selectedItemBg.visible = false;
            addChild(_selectedItemBg);
        }

        /**
         * Draw item (Done in Subclass)
         */
        protected function drawItem():void
        {
            trace("drawing item asset");
        }

        private function showSelectedBackground():void
        {
            _selectedItemBg.visible = true;
        }

        private function hideSelectedBackground():void
        {
            _selectedItemBg.visible = false;
        }
    }
}