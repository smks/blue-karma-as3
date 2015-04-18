package dialogue.character.compound
{
    import assets.CharacterDialogueMessageAssets;

    import dialogue.character.AbstractCharacterDialogue;
    import dialogue.character.repositories.SlumsStreetDialogueRepository;
    import dialogue.plaques.Plaque;

    /**
     * ...
     * @author @shaun
     */
    public class RileyDawson extends AbstractCharacterDialogue
    {
        public function RileyDawson(convoId:String = 'riley_dawson_1')
        {
            setConvoId(convoId);
            super();
        }

        override protected function drawDialogue():void
        {
            addDialogueBackground();
            addPlaques(Plaque.RILEY, Plaque.DAWSON);
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