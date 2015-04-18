package bluekarma.dialogue.character.slumsstreet.riley_gang
{
    import assets.CharacterDialogueMessageAssets;

    import dialogue.character.repositories.SlumsStreetDialogueRepository;
    import dialogue.character.AbstractCharacterDialogue;
    import dialogue.plaques.Plaque;

    import global.Global;

    /**
     * ...
     * @author @shaun
     */
    public class RileyGang extends AbstractCharacterDialogue
    {
        private var gangQues:Array = [2, 4, 6, 8, 10];

        public function RileyGang(convoId:String = CharacterDialogueMessageAssets.RILEY_GANG_1)
        {
            setConvoId(convoId);
            super();
        }

        override protected function drawDialogue():void
        {
            addDialogueBackground();
            addPlaques(Plaque.RILEY, Plaque.DANNY, Plaque.BILLY, Plaque.CHARLIE);
            addDialogueRepo();
        }

        override protected function composeDialogue():void
        {
            handleConversation();
        }

        override protected function showNextMessage():void
        {
            if (Global.inArray(_messageCounter, gangQues)) {
                toggleRightPlaque();
            }
            super.showNextMessage();
        }

        override public function toggleRightPlaque():void
        {
            if (_rightPlaque.visible === true) {
                _rightPlaque.visible = false;
                _rightPlaque2.visible = true;
                _rightPlaque3.visible = false;
            } else if (_rightPlaque2.visible === true) {
                _rightPlaque.visible = false;
                _rightPlaque2.visible = false;
                _rightPlaque3.visible = true;
            } else if (_rightPlaque3.visible === true) {
                _rightPlaque.visible = true;
                _rightPlaque2.visible = false;
                _rightPlaque3.visible = false;
            }
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