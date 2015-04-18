package interactive.slumsstreet.characters
{
    import assets.Level1CharacterAssets;

    import bluekarma.interactive.base.Character;
    import bluekarma.interactive.base.InteractionRepoFactory;

    import starling.display.MovieClip;
    import starling.core.Starling;

    /**
     * Interactive Character: Charlie
     * @author Shaun Stone
     * Created at: {$date}
     */
    public class Charlie extends Character
    {
        public function Charlie(id:String, talkable:Boolean = false, examinable:Boolean = false)
        {
            super(id, talkable, examinable);
            setFetchSingleRandomMessage(true);
        }

        /**
         * Get the character Assets and draw either a Sprite
         * Or a Movieclip, if the latter; add to the Juggler
         * and add to the container */
        override protected function drawCharacter():void
        {
            super.drawCharacter();
            //character down the first alley
            _object = new MovieClip(Level1CharacterAssets.getAtlas().getTextures("charlie"));
            _object.setFrameDuration(0, 6);
            //add to stage
            addChild(_object);
            //add animation of character
            Starling.juggler.add(_object);
        }

        /**
         * When interacting with Character we need to use
         * a Factory to pull back the right dialogue context
         * This in most cases needs to be overriden
         */
        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.SLUMS_STREET;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        /**
         * Override Trigger Interaction Object and
         * create new behaviour for Character
         */
        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject();
        }
    }
}