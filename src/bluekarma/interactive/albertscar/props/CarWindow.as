package interactive.albertscar.props
{
    import bluekarma.assets.settings.backgrounds.albertscar.AlbertJourneyAssets;
    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.base.Prop;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    import starling.display.MovieClip;

    /**
     * ...
     * @author Shaun Stone
     */
    public class CarWindow extends Prop
    {
        private var windows:Image;

        public function CarWindow(id:String, _examinable:Boolean = false)
        {
            super(id, _examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            super.getPropAsset(id);
            windows = new Image(AlbertJourneyAssets.getAtlas().getTexture("car-windows"));
            windows.x = 1;
            windows.y = 92;
            addChild(windows);
        }

        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.ALBERTS_CAR;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }
    }
}