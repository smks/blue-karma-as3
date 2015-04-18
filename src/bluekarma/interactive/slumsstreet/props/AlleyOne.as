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
    public class AlleyOne extends Prop
    {
        private var alley:Image;

        public function AlleyOne(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            alley = new Image(Level1Assets.getAtlas().getTexture(Level1Assets.SLUMSSTREETALLEYONE));
            addChild(alley);
        }

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