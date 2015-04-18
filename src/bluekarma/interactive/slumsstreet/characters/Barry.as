package interactive.slumsstreet.characters
{
    import assets.Level1CharacterAssets;

    import bluekarma.interactive.base.Character;
    import bluekarma.interactive.base.InteractionRepoFactory;

    import starling.core.Starling;
    import starling.display.MovieClip;

    /**
     * ...
     * @author ...
     */
    public class Barry extends Character
    {
        private var _isWatching:Boolean = true;

        public function Barry(id:String, talkable:Boolean = false, examinable:Boolean = false)
        {
            super(id, talkable, examinable);
            // make random messages appear
            setFetchSingleRandomMessage(true);
        }

        override protected function drawCharacter():void
        {
            super.drawCharacter();
            //character down the first alley
            _object = new MovieClip(Level1CharacterAssets.getAtlas().getTextures("barry"));
            _object.setFrameDuration(0, 6);
            //add to stage
            addChild(_object);
            //add animation of character
            Starling.juggler.add(_object);
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

        public function isWatching():Boolean
        {
            return _isWatching;
        }
    }
}