package dialogue.phone.conversations
{
    import dialogue.phone.repositories.RileryAlbertRepository;

    import flash.events.Event;

    import dialogue.phone.AbstractPhoneDialogue;
    import dialogue.phone.components.PhoneButton;
    import dialogue.phone.components.PhoneReception;
    import dialogue.phone.components.PhoneStatus;

    import flash.events.TimerEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.utils.Dictionary;
    import flash.utils.Timer;

    import starling.events.Event;
    import starling.text.TextField;
    import starling.display.Image;

    import dialogue.plaques.Plaque;

    import assets.PhoneDialogueAssets;

    import dialogue.phone.repositories.RileryTyroneApartmentRepository

    /**
     * ...
     * @author Shaun Stone
     */
    public class RileyAlbertOne extends AbstractPhoneDialogue
    {
        public function RileyAlbertOne()
        {
            super();
            setConvoId("riley_albert_2");
        }

        /**
         * @desc this is where we draw the dialogue
         */
        override protected function drawDialogue():void
        {
            addDialogueBackground();
            addPlaques(Plaque.RILEY, Plaque.ALBERT);
            addReception(PhoneReception.AVERAGE);
            addPhoneStatus(PhoneStatus.CALLING);
            addPhoneButtons();
            addConversationTimer();
            addDialogueRepo();
            disablePhoneButton(_phoneButtonAnswer);
        }

        override protected function addDialogueRepo():void
        {
            //_repo = new RileryTyroneApartmentRepository(_convoId);
            _repo = new RileryAlbertRepository(_convoId);
        }

        /**
         * @desc set up all variables
         */
        override protected function composeDialogue():void
        {
            // set current state
            setCurrentState(AWAITING_PHONE_ANSWER);
            //Listen for phone button triggers
            addEventListener("phoneButtonTriggered", phoneButtonHandler);
        }

        override protected function addMuteButton():void
        {
            super.addMuteButton();
            _phoneButtonMute.disableButton();
        }

        override protected function addLoudspeakerButton():void
        {
            super.addLoudspeakerButton();
            _phoneButtonLoudspeaker.disableButton();
        }

        override protected function addHangUpButton():void
        {
            super.addHangUpButton();
            _phoneButtonHangUp.disableButton();
        }

        public function phoneAnsweredByReceiver():void
        {
            answerThePhone();
            handlePhoneConversation();
        }
		
		override protected function addPlaqueCalling(name:String = 'Albert Green'):void 
		{
			super.addPlaqueCalling(name);
		}
    }
}