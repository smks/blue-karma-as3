package interactive.slumsstreet.characters
{
    import assets.Level1CharacterAssets;

    import bluekarma.interactive.base.Character;
    import bluekarma.interactive.base.InteractionRepoFactory;

    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.MovieClip;

    /**
     * ...
     * @author ...
     */
    public class Roger extends Character
    {
        private var _rogerBody:Image;
		private var sleeping:Boolean = false;

        public function Roger(id:String, talkable:Boolean = false, examinable:Boolean = false)
        {
            super(id, talkable, examinable);
            // make random messages appear
            setFetchSingleRandomMessage(false);
        }

        override protected function drawCharacter():void
        {
            super.drawCharacter();
            //_rogerBody = new Image(Level1CharacterAssets.getAtlas().getTexture("roger"));
            //addChild(_rogerBody);
            //character down the first alley
            _object = new MovieClip(Level1CharacterAssets.getAtlas().getTextures("roger"));
            _object.setFrameDuration(1, 6);
            //add to stage
            addChild(_object);
            //add animation of character
            Starling.juggler.add(_object);
            _object.play();
        }
		
		override public function triggerExamine(params:Object = null):void 
		{
			if (sleeping) {
				return;
			}
			super.triggerExamine(params);
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

        public function sleep():void
        {
            _object.stop();
            _object.currentFrame = 0;
			setSleeping(true);
        }
		
		public function getSleeping():Boolean 
		{
			return sleeping;
		}
		
		public function setSleeping(value:Boolean):void 
		{
			sleeping = value;
		}
    }
}