package bluekarma.interactive.slumsstreet.characters
{
    import assets.Level1CharacterAssets;

    import bluekarma.interactive.base.Character;
    import bluekarma.interactive.base.InteractionRepoFactory;

    import starling.display.MovieClip;
    import starling.display.Image;
    import starling.core.Starling;

    /**
     * Interactive Character: Graham
     * @author Shaun Stone
     * Created at: 17-02-2015 13:07:38
     */
    public class Graham extends Character
    {
        /**
         * The Character asset name for Graham
         * @param graham
         */
        public static const ASSET_NAME:String = "graham";
        /**
         * The Character Sprite or Movieclip
         * @param character
         */
        private var character:MovieClip;
        /*
         * Main Constructor, override any default properties here
         */
        public function Graham(id:String, talkable:Boolean = false, examinable:Boolean = false)
        {
            // Call parent Character class to set generic properties
            super(id, talkable, examinable);
            // Does the player need to be near the character to speak?
            
            // When we examine the character, do we pull back a random observation message,
            // or do we play through all messages from the XML file?
            setFetchSingleRandomMessage(false);
        }

        /**
         * Get the character Assets and draw either a Sprite
         * Or a Movieclip, if the latter; add to the Juggler
         * and add to the container
         */
        override protected function drawCharacter():void
        {
            // Call parent to trace that we are; drawing the Character
            super.drawCharacter();
            // Create a Sprite alternative with no animation - ( hidden by default )
            // Create a Movieclip with animation - shown by default
            character = new MovieClip(Level1CharacterAssets.getAtlas().getTextures(Graham.ASSET_NAME));
            character.setFrameDuration(0, 2);
            addChild(character);
            Starling.juggler.add(character);
            character.play();
        }

        /**
         * When interacting with Character we need to use
         * a Factory to pull back the right dialogue context.
         * This in most cases needs to be overridden.
         */
        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.SLUMS_STREET;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        /*
         * Override Trigger Interaction Object and create new behaviour for Character
         * @examples
         *  params.currentState - trigger an object dependent on the state of level
         *  params.playerPosition - x position to determine if player is near the object
         *  params.* pass in anything necessary
         */
        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject();
        }

        /**
         * When TriggerChat is called, we may want to do* something other than what's
         * expected for the character
         * @param params - pass in parameters we may want to use
         */
        override public function triggerChat(params:Object = null):void
        {
            super.triggerChat();
        }

        /**
         * When TriggerExamine is called, we may want to do
         * something other than what's expected for the character
         * @param params - pass in parameters we may want to use
         */
        override public function triggerExamine(params:Object = null):void
        {
            super.triggerExamine(params);
        }
    }
}