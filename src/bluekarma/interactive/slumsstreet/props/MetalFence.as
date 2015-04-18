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
    public class MetalFence extends Prop
    {
        private var _metalFence:Image;

        public function MetalFence(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        /**
         *
         * @param    id
         */
        override protected function getPropAsset(id:String):void
        {
            _metalFence = new Image(Level1Assets.getAtlas().getTexture(Level1Assets.SLUMSSTREETMETALFENCE));
            _metalFence.touchable = false;
            addChild(_metalFence);
        }

        /**
         *
         */
        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.SLUMS_STREET;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }
    }
}