package interactive.compound.props
{
    import assets.CompoundAssets;

    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.base.Prop;

    import starling.display.Image;

    /**
     * Interactive Prop: Door
     * @author Shaun Stone (SMKS)
     * @website http://www.smks.co.uk
     * Created at: 08-01-2015 20:04:38
     */
    public class Door extends Prop
    {
        /**
         * The image retrieved from Assets
         */
        private var doorOpen:Image;
        private var doorClosed:Image;
        private var _isDoorOpen:Boolean = false;

        /**
         * Main Constructor, override any default properties here
         */
        public function Door(id:String, examinable:Boolean = false)
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
            doorOpen = new Image(CompoundAssets.getAtlas().getTexture(CompoundAssets.DOOR_OPEN));
            doorOpen.x = -65;
            doorOpen.y = 0;
            doorOpen.pivotX = 0;
            doorOpen.pivotY = 0;
            doorOpen.scaleX = 1;
            doorOpen.scaleY = 1;
            addChild(doorOpen);
            doorClosed = new Image(CompoundAssets.getAtlas().getTexture(CompoundAssets.DOOR_CLOSED));
            doorClosed.x = 0;
            doorClosed.y = 0;
            doorClosed.pivotX = 0;
            doorClosed.pivotY = 0;
            doorClosed.scaleX = 1;
            doorClosed.scaleY = 1;
            addChild(doorClosed);
            // close door by default without sound
            closeDoor(false);
        }

        /**
         * Choose the repo to retrieve the prop from
         */
        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.COMPOUND;
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
            if (params.level.isDawsonInRoom() === true) {
                super.triggerInteractionObject(params);
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

        public function openDoor():void
        {
            SoundAssets.apartmentDoorOpen.play();
            doorClosed.visible = false;
            doorOpen.visible = true;
            setIsDoorOpen(true);
        }

        public function closeDoor(playSound:Boolean = true):void
        {
            if (playSound) {
                SoundAssets.apartmentDoorClose.play();
            }
            doorClosed.visible = true;
            doorOpen.visible = false;
            setIsDoorOpen(false);
        }

        public function getIsDoorOpen():Boolean
        {
            return _isDoorOpen;
        }

        /**
         * @param value
         */
        public function setIsDoorOpen(value:Boolean):void
        {
            _isDoorOpen = value;
        }
    }
}