package interactive.albertscar.repos
{
    import assets.dialogue.Level1DialogueAssets;

    import bluekarma.interactive.base.InteractionRepo;

    import flash.media.Sound;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AlbertsCarInteractionRepo extends InteractionRepo
    {
        public function AlbertsCarInteractionRepo()
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
            if (_xml == null) {
                throw new Error("XML was not creates!");
            }
        }

        protected function getXMLData():XML
        {
            //fetch xml object from assets
            return Level1DialogueAssets.getXMLData(Level1DialogueAssets.JOURNEY_1);
        }
    }
}