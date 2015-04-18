package interactive.backalley.props
{
    import assets.BackAlleyAssets;
	import levels.level1.part4.BackAlley;

    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.base.Prop;

    import starling.display.Image;

    /**
     * Interactive Prop: Toolbox
     * @author Shaun Stone
     * Created at: 01-01-2015 10:54:36
     */
    public class Toolbox extends Prop
    {
        /**
         * The image retrieved from Assets
         */
        private var toolbox:Image;
        private var toolboxOpen:Image;
        private var opened:Boolean = false;
        private var locked:Boolean = true;
        /*
         * Main Constructor, override any default properties here
         */
        public function Toolbox(id:String, examinable:Boolean = false)
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
            toolbox = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.TOOLBOX));
            toolbox.y = 30;
            addChild(toolbox);
            toolboxOpen = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.TOOLBOX_OPEN));
            addChild(toolboxOpen);
            // by default make toolbox locked
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

        /**
         * Override Trigger Interaction Object and create new behaviour for Item
         * @examples
         *  params.currentState - trigger an object dependent on the state of level
         *  params.playerPosition - x position to determine if player is near the object
         *  params.* pass in anything necessary
         */
        override public function triggerInteractionObject(params:Object = null):void
        {
            if (locked) {
                return;
            }
            if (this.isOpen()) {
				
				if (params.level.hasTakenKeyAndCrowbar() == true) {
					close();
				}
            }
        }

        /**
         * When TriggerExamine is called, we may want to do
         * something other than what's expected for the prop
         * @param params - pass in parameters we may want to use
         */
        override public function triggerExamine(params:Object = null):void
        {
			if (this.isLocked() === true) {
				params.level.getInventory().addReminder("toolbox_open", "find a way to open the toolbox", "critical");
			}
			
            super.triggerExamine(params);
        }
		
		private function isLocked():Boolean 
		{
			return locked;
		}

        public function open():void
        {
            if (locked) {
                SoundAssets.toolboxOpen.play();
                locked = false;
            }
            toolbox.visible = false;
            toolboxOpen.visible = true;
            setIsOpen(true);
        }

        public function close():void
        {
            toolbox.visible = true;
            toolboxOpen.visible = false;
            setIsOpen(false);
        }

        /**
         * @return bool
         */
        public function isOpen():Boolean
        {
            return this.opened;
        }

        private function setIsOpen(val:Boolean):void
        {
            this.opened = val;
        }
    }
}