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
    public class HouseWindow extends Prop
    {
        private var window:Image;

        public function HouseWindow(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            window = new Image(Level1Assets.getAtlas().getTexture(Level1Assets.SLUMSSTREETHOUSEWINDOW));
            addChild(window);
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