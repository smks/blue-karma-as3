package interactive.albertscar.characters
{
    import bluekarma.assets.characters.albertscar.AlbertAssets;
    import bluekarma.assets.settings.backgrounds.albertscar.AlbertJourneyAssets;
    import bluekarma.interactive.base.Character;
	import starling.display.Image;

    import starling.core.Starling;
    import starling.display.MovieClip;
    import starling.events.Event;

    import bluekarma.interactive.base.InteractionRepoFactory;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AlbertDriving extends Character
    {
        private var albert:Image;
        // this will be changed near the end of the journey
        private var allowedToTalk:Boolean = false;
		private var albertEyes:MovieClip;

        public function AlbertDriving(id:String, talkable:Boolean = false, examinable:Boolean = false)
        {
            super(id, talkable, examinable);
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawCharacter();
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            trace("triggered albert");
            super.triggerInteractionObject();
        }

        override protected function drawCharacter():void
        {
			albert = new Image(AlbertAssets.getAtlas().getTexture("albert_driving"));
            addChild(albert);
			
            albertEyes = new MovieClip(AlbertAssets.getAtlas().getTextures("albert_driving_eyes"), 6);
			albertEyes.x = 119;
			albertEyes.y = 75;
            Starling.juggler.add(albertEyes);
            albertEyes.setFrameDuration(0, 5);
            addChild(albertEyes);
            albertEyes.play();
        }

        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.ALBERTS_CAR;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        public function stop():void
        {
            albertEyes.stop();
        }
    }
}