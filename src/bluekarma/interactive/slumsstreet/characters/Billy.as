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
    public class Billy extends Character
    {
        public function Billy(id:String, talkable:Boolean = false, examinable:Boolean = false)
        {
            super(id, talkable, examinable);
            // make random messages appear
            setFetchSingleRandomMessage(true);
        }

        override protected function drawCharacter():void
        {
            super.drawCharacter();
            //character down the first alley
            _object = new MovieClip(Level1CharacterAssets.getAtlas().getTextures("billy"));
            _object.setFrameDuration(0, 4);
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
    }
}