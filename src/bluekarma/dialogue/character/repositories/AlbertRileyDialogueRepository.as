package dialogue.character.repositories
{
    import assets.CharacterDialogueSoundAssets;

    import dialogue.AbstractDialogueRepository;

    import flash.media.Sound;

    /**
     * ...
     * @author Shaun Stone
     *
     * This class deals with the XML messages and voice files for
     * @class AlbertRileyDialogueRepository
     */
    public class AlbertRileyDialogueRepository extends AbstractDialogueRepository
    {
        public function AlbertRileyDialogueRepository(convoId:String)
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

