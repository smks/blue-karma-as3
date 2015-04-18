package dialogue.phone.conversations
{
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
    public class RileyTyroneOne extends AbstractPhoneDialogue
    {
        public function RileyTyroneOne()
        {
            super();
            if (BlueKarma.ENVIRONMENT == BlueKarma.TESTING) {
                //_messageCounter = 21;
            } else {
                _messageCounter = 0;
            }
            setConvoId("riley_tyrone_1");
        }

        /**
         * @desc this is where we draw the dialogue
         */
        override protected function drawDialogue():void
        {
            addDialogueBackground();
			addPhoneStatus(PhoneStatus.CALLING);
            addPlaques(Plaque.RILEY_PYJAMAS, Plaque.TYRONE);
            addReception(PhoneReception.GOOD);
            addPhoneButtons();
            addConversationTimer();
            addDialogueRepo();
        }

        override protected function addDialogueRepo():void
        {
            _repo = new RileryTyroneApartmentRepository(_convoId);
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
		
		override protected function addPlaqueCalling(name:String = 'Tyrone Marshall'):void 
		{
			super.addPlaqueCalling(name);
		}
    }
}