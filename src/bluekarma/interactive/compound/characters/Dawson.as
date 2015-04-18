package bluekarma.interactive.compound.characters
{
    import assets.DawsonAssets;
    import assets.Level1CharacterAssets;

    import flash.globalization.StringTools;

    import bluekarma.interactive.base.Character;
    import bluekarma.interactive.base.InteractionRepoFactory;

    import flash.filters.GlowFilter;

    import global.Global;

    import starling.display.MovieClip;
    import starling.display.Image;
    import starling.core.Starling;
    import starling.filters.BlurFilter;
    import starling.utils.Color;

    /**
     * Interactive Character: Dawson
     * @author Shaun Stone
     * Created at: 21-02-2015 12:35:18
     */
    public class Dawson extends Character
    {
        /**
         * The Character asset name for Dawson
         * @param dawson
         */
        public static const ASSET_NAME:String = "dawson";
        /**
         * The Character Sprite or Movieclip
         * @param character
         */
        private var characterPacking:MovieClip;
        private var characterCuffed:MovieClip;
        /** Has he been cuffed? */
        private var cuffed:Boolean = false;
        /** Now he's cuffed, as he been taped? */
        private var taped:Boolean = false;
        /** has he also be tied up with cable? */
        private var tied:Boolean = false;
        /** Once he's tied and cuffed and taped, is he highlighted? */
        private var isChosen:Boolean = false;
        /*
         * Main Constructor, override any default properties here
         */
        public function Dawson(id:String, talkable:Boolean = false, examinable:Boolean = false)
        {
            // Call parent Character class to set generic properties
            super(id, talkable, examinable);
            // Does the player need to be near the character to speak?
            
            // When we examine the character, do we pull back a random observation message,
            // or do we play through all messages from the XML file?
            setFetchSingleRandomMessage(false);
        }

        static public function getId():String
        {
            return 'dawson';
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
            // Create a Movieclip with animation - shown by default
            characterPacking = new MovieClip(DawsonAssets.getAtlas().getTextures(DawsonAssets.PACKING), 24);
            // character.setFrameDuration(0, 2);
            addChild(characterPacking);
            Starling.juggler.add(characterPacking);
            characterPacking.play();
        }

        /**
         * When interacting with Character we need to use
         * a Factory to pull back the right dialogue context.
         * This in most cases needs to be overridden.
         */
        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.COMPOUND;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        /**
         * Override Trigger Interaction Object and create new behaviour for Character
         * @examples
         *  params.currentState - trigger an object dependent on the state of level
         *  params.playerPosition - x position to determine if player is near the object
         *  params.* pass in anything necessary
         */
        override public function triggerInteractionObject(params:Object = null):void
        {
            if (characterCuffed === null) {
                return;
            }
            if (readyToBeThrownOut() === false) {
                return;
            }
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

        /**
         *
         * @return
         */
        public function readyToBeThrownOut():Boolean
        {
            if (cuffed == true && tied == true && taped == true) {
                return true;
            }
            return false;
        }

        public function cuffDawson():void
        {
            setCuffed(true);
            Starling.juggler.remove(characterPacking);
            // remove packing dawson
            removeChild(characterPacking);
            characterCuffed = new MovieClip(DawsonAssets.getAtlas().getTextures(DawsonAssets.CUFFED), 24);
            characterCuffed.x = 60;
            characterCuffed.y = 90;
            addChild(characterCuffed);
            Starling.juggler.add(characterCuffed);
            characterCuffed.play();
        }

        /**
         * Getters and Setters
         */

        public function hasBeenCuffed():Boolean
        {
            return cuffed;
        }

        public function setBeenCuffed(value:Boolean):void
        {
            cuffed = value;
        }

        public function getTied():Boolean
        {
            return tied;
        }

        public function setTied(value:Boolean):void
        {
            tied = value;
        }

        public function tiedUp():Boolean
        {
            return tied;
        }

        public function tapedUp():Boolean
        {
            return taped;
        }

        public function setCuffed(boolean:Boolean):void
        {
            cuffed = true;
        }

        public function setTapedUp(boolean:Boolean):void
        {
            taped = boolean;
        }
    }
}