package interactive.slumsstreet.props
{
    import assets.Level1Assets;

    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.base.Prop;

    import starling.display.Image;

    /**
     * ...
     * @author @shaun
     */
    public class CompoundDoor extends Prop
    {
        private var door:Image;

        public function CompoundDoor(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            door = new Image(Level1Assets.getAtlas().getTexture(Level1Assets.SLUMSSTREETCOMPOUNDDOOR));
            addChild(door);
        }

        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.SLUMS_STREET;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            if (params.level.dawsonInRoom === true) {
                super.triggerInteractionObject(params);
            }
        }
    }
}