package bluekarma.dialogue.character.slumsstreet.riley_rupert
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
    public class RileyRupert extends AbstractCharacterDialogue
    {
        public function RileyRupert(convoId:String = "riley_rupert_1")
        {
            setConvoId(convoId);
            super();
        }

        override protected function drawDialogue():void
        {
            addDialogueBackground();
            addPlaques(Plaque.RILEY, Plaque.RUPERT);
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