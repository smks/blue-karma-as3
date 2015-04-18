package dialogue.character.compound
{
    import assets.CharacterDialogueMessageAssets;

    import dialogue.character.AbstractCharacterDialogue;
    import dialogue.character.repositories.SlumsStreetDialogueRepository;
    import dialogue.plaques.Plaque;

    import global.Global;

    /**
     * @author @shaun
     */
    public class DawsonBodyguards extends AbstractCharacterDialogue
    {
        public function DawsonBodyguards(convoId:String = "dawson_pablo")
        {
            setConvoId(convoId);
            if (BlueKarma.ENVIRONMENT == BlueKarma.TESTING) {
                setCounter(8);
            }
            super();
        }

        override protected function drawDialogue():void
        {
            addDialogueBackground();
            addPlaques(Plaque.UNKNOWN, Plaque.PABLO);
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