package interactive.backalley.props
{
    import assets.BackAlleyAssets;

    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.base.Prop;

    import starling.display.Image;

    /**
     * Interactive Prop: FanPanel
     * @author Shaun Stone
     * Created at: 26-12-2014 18:33:08
     */
    public class FanPanel extends Prop
    {
        /**
         * The image retrieved from Assets
         */
        private var closedPanel:Image;
        private var openPanel:Image;
        private var panelSwitch:Image;
        private var unlocked:Boolean = false;
        private var on:Boolean = false;
        /*
         * Main Constructor, override any default properties here
         */
        public function FanPanel(id:String, examinable:Boolean = false)
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
            openPanel = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.FAN_PANEL_OPEN));
            openPanel.x = -42;
            openPanel.y = -6;
            openPanel.visible = false;
            addChild(openPanel);
            panelSwitch = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.FAN_PANEL_SWITCH));
            this.switchOff();
            panelSwitch.visible = true;
            addChild(panelSwitch);
            closedPanel = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.FAN_PANEL_CLOSED));
            closedPanel.pivotX = 0;
            closedPanel.pivotY = 0;
            closedPanel.scaleX = 1;
            closedPanel.scaleY = 1;
            addChild(closedPanel);
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
        override public function triggerInteractionObject(params:Object = null):void{}

        /**
         * When TriggerExamine is called, we may want to do
         * something other than what's expected for the prop
         * @param params - pass in parameters we may want to use
         */
        override public function triggerExamine(params:Object = null):void
        {
            super.triggerExamine(params);
        }

        public function unlock():void
        {
            closedPanel.visible = false;
            openPanel.visible = true;
            unlocked = true;
        }

        public function lock():void
        {
            closedPanel.visible = true;
            openPanel.visible = false;
            unlocked = false;
        }

        public function switchOn():void
        {
			this.on = true;
            panelSwitch.x = 12;
            panelSwitch.y = 50;
        }

        public function switchOff():void
        {
			this.on = false;
            panelSwitch.x = 12;
            panelSwitch.y = 16;
        }

        /**
         * @return bool
         */
        public function isUnlocked():Boolean
        {
            return this.unlocked;
        }

        /**
         * @return bool
         */
        public function isOn():Boolean
        {
            return on;
        }
    }
}