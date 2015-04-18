package interactive.slumsstreet.props
{
	import assets.BackAlleyAssets;
    import assets.Level1Assets;

    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.base.Prop;

    import starling.display.Image;

    /**
     * ...
     * @author @shaun
     */
    public class MetalFenceDoor extends Prop
    {
        public static const STREETS:String = "streets";
        public static const BACK_ALLEY:String = "back_alley";
        private var _metalFenceDoorShut:Image;
        private var _metalFenceDoorOpen:Image;
        private var _open:Boolean = false;

        public function MetalFenceDoor(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
            setActionable(false);
            
        }

        override protected function getPropAsset(id:String):void
        {
            //add shut door
            _metalFenceDoorShut = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.METAL_FENCE_DOOR_CLOSED));
            addChild(_metalFenceDoorShut);
            //add open door
            _metalFenceDoorOpen = new Image(Level1Assets.getAtlas().getTexture(BackAlleyAssets.METAL_FENCE_DOOR_OPEN));
            _metalFenceDoorOpen.visible = false;
            addChild(_metalFenceDoorOpen);
        }

        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.SLUMS_STREET;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            if (params.currentState < 3) {
                // explain you cannot do it
                super.triggerInteractionObject(params);
            }
        }

        public function open():void
        {
            _open = true;
            _metalFenceDoorShut.visible = false;
            _metalFenceDoorOpen.visible = true;
        }

        public function close():void
        {
            _open = false;
            _metalFenceDoorShut.visible = true;
            _metalFenceDoorOpen.visible = false;
        }

        public function isOpen():Boolean
        {
            return _open;
        }

        /**
         * Repo can be different
         * @param    level
         */
        public function setLevelItem(level:String):void
        {
            switch (level) {
                case STREETS:
                    _repoId = InteractionRepoFactory.SLUMS_STREET;
                    break;
                case BACK_ALLEY:
                    _repoId = InteractionRepoFactory.BACK_ALLEY;
                    break;
                default:
                    throw new Error("Couldn't set level item for " + _id);
            }
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }
    }
}