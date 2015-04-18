package interactive.apartment.repos
{
    import assets.dialogue.Level1DialogueAssets;

    import flash.media.Sound;

    import bluekarma.interactive.base.InteractionRepo;

    /**
     * ...
     * @author Shaun Stone
     */
    public class ApartmentInteractionRepo extends InteractionRepo
    {
        public function ApartmentInteractionRepo()
        {
            fetchData();
        }

        override public function getVoiceFile(voiceFileName:String):Sound //return sound
        {
            //store reference
            var voiceFile:Sound = Level1DialogueAssets.getVoiceFile(voiceFileName);
            //remove for garbage collection
            Level1DialogueAssets.disposeOfVoiceFile(voiceFileName);
            //return
            return voiceFile;
        }

        protected function fetchData():void
        {
            _xml = getXMLData();

        }
        protected function getXMLData():XML
        {
            //fetch xml object from assets
            return Level1DialogueAssets.getXMLData(Level1DialogueAssets.APARTMENT_1);
        }
    }
}