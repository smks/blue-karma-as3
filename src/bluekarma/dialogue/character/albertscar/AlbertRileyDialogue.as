package dialogue.character.albertscar
{
    import dialogue.character.repositories.AlbertRileyDialogueRepository;
    import dialogue.character.AbstractCharacterDialogue;
    import dialogue.plaques.Plaque;

    import flash.media.Sound;
    import flash.media.SoundChannel;

    /**
     * ...
     * @author shaun stone
     *
     * @desc First conversation between Riley and Albert. Albert however does not speak.
     *
     */
    public class AlbertRileyDialogue extends AbstractCharacterDialogue
    {
        public static const CONVO_1:String = "riley_albert_1";
        public static const CONVO_2:String = "riley_albert_2";
        private var MESSAGE_START_POSITION:uint = 0; // change back to 0
        //protected var _repo:RileryTyroneApartmentRepository;
        public function AlbertRileyDialogue(convoId:String)
        {
            super();
            setConvoId(convoId);
        }

        override protected function drawDialogue():void
        {
            addDialogueBackground();
            addPlaques(Plaque.RILEY, Plaque.ALBERT);
            addDialogueRepo();
        }

        override protected function composeDialogue():void
        {
            _messageCounter = MESSAGE_START_POSITION;
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
            _repo = new AlbertRileyDialogueRepository(_convoId);
        }
    }
}