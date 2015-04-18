package dialogue.character.repositories
{
    import assets.CharacterDialogueSoundAssets;

    import dialogue.AbstractDialogueRepository;

    import flash.media.Sound;

    /**
     *
     * Roger, Jake, Barry, Pablo conversations
     *
     * @author Shaun Stone
     *
     * This class deals with the XML messages and voice files for
     * @class SlumsStreet
     */
    public class SlumsStreetDialogueRepository extends AbstractDialogueRepository
    {
        public function SlumsStreetDialogueRepository(convoId:String)
        {
            super(convoId);
        }

        public function getVoiceFile(voiceFileName:String):Sound //return sound
        {
            //store reference
            var voiceFile:Sound = CharacterDialogueSoundAssets.getVoiceFile(voiceFileName);
            //remove for garbage collection
            CharacterDialogueSoundAssets.disposeOfVoiceFile(voiceFileName);
            //return
            return voiceFile;
        }
    }
}

