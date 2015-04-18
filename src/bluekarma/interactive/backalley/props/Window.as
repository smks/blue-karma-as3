package interactive.backalley.props
{
    import assets.BackAlleyAssets;
	import notifications.reminders.Reminder;

    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.base.Prop;

    import interfaces.IOpenable;

    import starling.display.Image;

    /**
     * Interactive Prop: Window
     * @author Shaun Stone
     * Created at: 06-12-2014 14:04:12
     */
    public class Window extends Prop implements IOpenable
    {
        /**
         * The image retrieved from Assets
         */
        private var windowOpen:Image;
        private var windowClosed:Image;
        private var opened:Boolean = false;
        private var locked:Boolean = true;
        /*
         * Main Constructor, override any default properties here
         */
        public function Window(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
            setExaminable(true);
            setTouchable(true);
        }

        /**
         * Retrieve Image from assets then draw the prop
         *
         */
        override protected function getPropAsset(id:String):void
        {
            windowOpen = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.WINDOW_OPEN));
            windowOpen.x = 0;
            windowOpen.y = 0;
            windowOpen.pivotX = 0;
            windowOpen.pivotY = 0;
            windowOpen.scaleX = 1;
            windowOpen.scaleY = 1;
            addChild(windowOpen);
            windowClosed = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.WINDOW_CLOSED));
            windowClosed.x = 113;
            windowClosed.y = 0;
            windowClosed.pivotX = 0;
            windowClosed.pivotY = 0;
            windowClosed.scaleX = 1;
            windowClosed.scaleY = 1;
            addChild(windowClosed);
            this.close();
        }

        /**
         * Choose the repo to retrieve the prop from
         */
        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.BACK_ALLEY;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            if (locked) {
				params.level.getInventory().addReminder(
					"window_break_in", 
					"find a tool to open the window", 
					Reminder.HIGH
				);
                return;
            }
            if (this.isOpen()) {
                close();
            } else {
                open();
            }
        }

        /**
         * When TriggerExamine is called, we may want to do
         * something other than what's expected for the prop
         * @param params - pass in parameters we may want to use
         */
        override public function triggerExamine(params:Object = null):void
        {
            super.triggerExamine(params);
        }

        public function open():void
        {
            if (locked) {
                setLocked(false);
                SoundAssets.windowBreak.play();
            }
            windowOpen.visible = true;
            windowClosed.visible = false;
            setIsOpen(true);
        }

        public function close():void
        {
            windowOpen.visible = false;
            windowClosed.visible = true;
            setIsOpen(false);
        }

        /*
         * Override Trigger Interaction Object and create new behaviour for Item
         * @examples
         *  params.currentState - trigger an object dependent on the state of level
         *  params.playerPosition - x position to determine if player is near the object
         *  params.* pass in anything necessary
         */
        /**
         * @return bool
         */
        public function isOpen():Boolean
        {
            return this.opened;
        }

        public function getLocked():Boolean
        {
            return locked;
        }

        public function setLocked(value:Boolean):void
        {
            locked = value;
        }

        /**
         *
         * @param val
         */
        private function setIsOpen(val:Boolean):void
        {
            this.opened = val;
        }
    }
}