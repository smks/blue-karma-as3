package bluekarma.dialogue.character.slumsstreet.riley_roger
{
    import assets.CharacterDialogueMessageAssets;

    import dialogue.character.repositories.AlbertRileyDialogueRepository;
    import dialogue.character.repositories.SlumsStreetDialogueRepository;
    import dialogue.character.AbstractCharacterDialogue;
    import dialogue.plaques.Plaque;

    import flash.media.Sound;
    import flash.media.SoundChannel;

    import global.Global;

    /**
     * ...
     * @author shaun stone
     *
     * @desc Conversations along slums street
     *
     */
    public class RileyRoger extends AbstractCharacterDialogue
    {
        public function RileyRoger(convoId:String = CharacterDialogueMessageAssets.RILEY_ROGER_1)
        {
            setConvoId(convoId);
            super();
        }

        override protected function drawDialogue():void
        {
            addDialogueBackground();
            addPlaques(Plaque.RILEY, Plaque.ROGER);
            addDialogueRepo();
        }

        override protected function composeDialogue():void
        {
            handleConversation();
        }

        protected function handleConversation():void
        {
            fetchMessages();
            showNextMessage();
            handleConversationFlow();
        }

        private function addDialogueRepo():void
        {
            _repo = new SlumsStreetDialogueRepository(_convoId);
        }
    }
}