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
    public class Jacob extends Character
    {
        public function Jacob(id:String, talkable:Boolean = false, examinable:Boolean = false)
        {
            super(id, talkable, examinable);
        }

        override protected function drawCharacter():void
        {
            super.drawCharacter();
            _object = new MovieClip(Level1CharacterAssets.getAtlas().getTextures("jacob"));
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