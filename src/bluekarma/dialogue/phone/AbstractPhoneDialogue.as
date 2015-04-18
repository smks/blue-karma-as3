package dialogue.phone
{
    import assets.PhoneDialogueAssets;
	import dialogue.plaques.PlaqueStatus;

    import global.Global;

    import dialogue.AbstractDialogue;
    import dialogue.phone.components.PhoneButton;
    import dialogue.phone.components.PhoneReception;
    import dialogue.phone.components.PhoneStatus;
    import dialogue.plaques.Plaque;

    import flash.events.TimerEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
    import flash.utils.Dictionary;
    import flash.utils.Timer;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AbstractPhoneDialogue extends AbstractDialogue
    {
		public const PLAQUE_STATUS_RIGHT_X:uint = 661;
		
		private var plaqueStatus:PlaqueStatus;
        public const FULL_VOLUME:uint = 1;
        public const MUTED:uint = 0;
        protected const AWAITING_PHONE_ANSWER:uint = 0; // this is the state when in phone dashboard waiting to answer phone
        protected const IN_CONVERSATION:uint = 1; // this is when riley and tyrone are talking
        protected const CONVERSATION_ENDED:uint = 2; // when the conversation has finished, waiting for user to end call
        protected const FINISHED:uint = 3; // when the user has closed the session
        protected var _messageStartPosition:uint = 0;
        protected var _reception:PhoneReception;
        protected var _phoneStatus:PhoneStatus;
        protected var _phoneButtonMute:PhoneButton;
        protected var _phoneButtonLoudspeaker:PhoneButton;
        protected var _phoneButtonAnswer:PhoneButton;
        protected var _phoneButtonHangUp:PhoneButton;
        protected var _convoTimer:TextField;
        protected var _convoText:TextField;
        protected var _convoTimerValue:uint;
        protected var _callDurationTimer:Timer;
        protected var _currentState:uint;
        protected var _messageVoiceFiles:Array;
        protected var _speakers:Array;
        protected var _currentVoiceFile:Sound;
        protected var _currentVoiceFileSoundChannel:SoundChannel;
        protected var _currentVoiceFileSoundTransform:SoundTransform;
        protected var _repo:*;

        public function AbstractPhoneDialogue()
        {
            super();
            _currentVoiceFileSoundChannel = new SoundChannel();
            _currentVoiceFileSoundTransform = new SoundTransform(1);
        }

        /**
         * This will get all xml messages and voice files
         *
         */
        override protected function fetchMessages():void
        {
            addMessagesToArray();
            addMessageVoiceFilesToArray();
            /**
             * debugging purposes
             */
            for (var i:uint = 0; i < _messages.length; i++) {
                trace(_messages[i]);
                trace(_messageVoiceFiles[i]);
            }
            /* */
        }

        public function getConvoTimer():String
        {
            return _convoTimer.text;
        }

        //this will answer the phone and configure to Match
        /**
         * Update the time of conversation timer
         *
         * @param    value
         */
        public function setConvoTimer(time:uint):void
        {
            _convoTimer.text = secondsToHMS(time);
        }

        public function setMessageStartPosition(index:uint):void
        {
            _messageCounter = index;
        }

        public function getCurrentState():uint
        {
            return _currentState;
        }

        public function setCurrentState(value:uint):void
        {
            _currentState = value;
        }

        protected function addDialogueRepo():void
        {
            throw new Error("This method should be overriden in subclass");
        }

        /**
         * Add the necessary Buttons to phone UI
         *
         */
        protected function addPhoneButtons():void
        {
            addMuteButton();
            addLoudspeakerButton();
            addAnswerButton();
            addHangUpButton();
        }

        protected function answerThePhone():void
        {
            // START THE CALL TIMER
            initialiseCallDurationTimer();
            disablePhoneButton(_phoneButtonAnswer);
            enablePhoneButton(_phoneButtonMute);
            enablePhoneButton(_phoneButtonHangUp);
            //set state to connected
            _phoneStatus.setStatusConnected();
			
			plaqueStatus.hideAndRemove();
        }

        protected function handleConversationFlow():void
        {
            if (_messageCounter >= _totalMessages) {
                return;
            } else {
                _currentVoiceFile = _repo.getVoiceFile(_messageVoiceFiles[_messageCounter]);
                _currentVoiceFileSoundChannel = _currentVoiceFile.play();
                _currentVoiceFileSoundChannel.soundTransform = _currentVoiceFileSoundTransform;
                _currentVoiceFileSoundChannel.addEventListener(flash.events.Event.SOUND_COMPLETE, whenStoppedSpeakingHandler);
            }
        }

        protected function addMessagesToArray():void
        {
            //prepare messages
            _messages = new Array();
            //pass message array from repo
            _messages = _repo.findMessagesByConvoId();
            _totalMessages = _messages.length;
            // add speakers also so we can determine who is speaking
            _speakers = _repo.findSpeakersByConvoId();
        }

        protected function addMessageVoiceFilesToArray():void
        {
            //prepare message voice files
            _messageVoiceFiles = new Array();
            //pass message voice files into dictionary
            _messageVoiceFiles = _repo.findMessageVoiceFilesByConvoId();
        }

        protected function phoneButtonHandler(e:starling.events.Event):void
        {
            switch (e.data) {
                case PhoneButton.ANSWER:
                    handlePhoneAnswer();
                    break;
                case PhoneButton.LOUDSPEAKER:
                    handlePhoneLoudspeaker();
                    break;
                case PhoneButton.MUTE:
                    handlePhoneMute();
                    break;
                case PhoneButton.END_CALL:
                    handlePhoneEndCall();
                    break;
                default:
                    throw new Error("The data didn't match correct name");
            }
        }

        protected function handlePhoneEndCall():void
        {
            switch (_currentState) {
                case IN_CONVERSATION :
                    handlePhoneConversationComplete(true);
                    parent.dispatchEventWith("PhoneCallEnded");
                    break;
                case CONVERSATION_ENDED:
                    parent.dispatchEventWith("PhoneCallEnded");
                    //this.removeFromParent(true);
                    break;
            }
        }

        protected function handlePhoneConversationIterator():void
        {
            //check if messages exceeds total messages
            if (_messageCounter >= _totalMessages - 1) {
                handlePhoneConversationComplete();
            } else {

                // add 1 to message counter
                incrementMessageCounter();
                //if not then increase message counter
                showNextMessage();
                //play the next voice file in pipe line
                handleConversationFlow();
            }
        }

        protected function showNextMessage():void
        {
            var textColour:uint;
            // change text colour based on who is speaking
            if (String(_speakers[_messageCounter]) === 'riley') {
                textColour = Global.BLUE_KARMA_WHITE;
            } else {
                textColour = Global.BLUE_KARMA_DIALOGUE_BLUE;
            }
            if (_convoText == null) {
                _convoText = new TextField(
                        700,
                        100,
                        _messages[_messageCounter],
                        Global.DEFAULT_FONT,
                        20,
                        textColour
                );
                _convoText.x = 161;
                _convoText.y = 540;
                addChild(_convoText);
            } else {
                _convoText.color = textColour;
                _convoText.text = _messages[_messageCounter];
            }
        }

        /**
         * Phone Conversation Complete Logic
         */
        protected function handlePhoneConversationComplete(early:Boolean = false):void
        {
            disablePhoneButton(_phoneButtonLoudspeaker);
            disablePhoneButton(_phoneButtonMute);
            //stop call duration counting
            completedCallDurationTimer();
            //make phone disconnected
            _phoneStatus.setStatusDisconnected();
            //_phoneButtonHangUp.disableButton();
            if (early) {
                _currentVoiceFileSoundChannel.stop();
            }
            //remove sound transform
            _currentVoiceFileSoundChannel.removeEventListener(flash.events.Event.SOUND_COMPLETE, whenStoppedSpeakingHandler);
            //set state to complete
            setCurrentState(CONVERSATION_ENDED);
			
			addPlaqueDisconnected();
        }

        protected function mutePhoneCall():void
        {
            if (_currentVoiceFileSoundTransform !== null) {
                _currentVoiceFileSoundTransform.volume = this.MUTED;
                _currentVoiceFileSoundChannel.soundTransform = _currentVoiceFileSoundTransform;
            }
            disablePhoneButton(_phoneButtonMute);
            enablePhoneButton(_phoneButtonLoudspeaker);
        }

        protected function unMutePhoneCall():void
        {
            if (_currentVoiceFileSoundChannel !== null) {
                _currentVoiceFileSoundTransform.volume = this.FULL_VOLUME;
                _currentVoiceFileSoundChannel.soundTransform = _currentVoiceFileSoundTransform;
            }
            disablePhoneButton(_phoneButtonLoudspeaker);
            enablePhoneButton(_phoneButtonMute);
        }

        protected function initialiseCallDurationTimer():void
        {
            _callDurationTimer = new Timer(1000, Number.MAX_VALUE);
            _callDurationTimer.addEventListener(TimerEvent.TIMER, updateCallDurationTimer);
            _callDurationTimer.start();
        }

        protected function updateCallDurationTimer(e:TimerEvent):void
        {
            _convoTimerValue++;
            setConvoTimer(_convoTimerValue);
        }

        protected function completedCallDurationTimer():void
        {
            if (_callDurationTimer !== null) {
                //add time records (later date)
                _callDurationTimer.removeEventListener(TimerEvent.TIMER, updateCallDurationTimer);
            }
        }

        /**
         * Add Mute Button
         *
         */
        protected function addMuteButton():void
        {
            _phoneButtonMute = new PhoneButton(PhoneButton.MUTE);
            _phoneButtonMute.x = 560;
            _phoneButtonMute.y = 191;
            addChild(_phoneButtonMute);
        }

        protected function handlePhoneMute():void
        {
            mutePhoneCall();
        }

        protected function handlePhoneLoudspeaker():void
        {
            unMutePhoneCall();
        }

        protected function handlePhoneAnswer():void
        {
            switch (_currentState) {
                case AWAITING_PHONE_ANSWER:
                    answerThePhone();
                    handlePhoneConversation();
                    break;
            }
        }

        /**
         * Phone Conversation Logic
         */
        protected function handlePhoneConversation():void
        {
            parent.dispatchEventWith("phoneHasBeenAnswered");
            // set current state
            setCurrentState(IN_CONVERSATION);
            fetchMessages();
            showNextMessage();
            handleConversationFlow();
        }

        /**
         * Add Loudspeaker Button
         *
         */
        protected function addLoudspeakerButton():void
        {
            _phoneButtonLoudspeaker = new PhoneButton(PhoneButton.LOUDSPEAKER);
            _phoneButtonLoudspeaker.x = 560;
            _phoneButtonLoudspeaker.y = 92;
            addChild(_phoneButtonLoudspeaker);
        }

        /**
         * Add Answer Button
         *
         */
        protected function addAnswerButton():void
        {
            _phoneButtonAnswer = new PhoneButton(PhoneButton.ANSWER);
            _phoneButtonAnswer.x = 560;
            _phoneButtonAnswer.y = 289;
            addChild(_phoneButtonAnswer);
        }

        /**
         * Add Hangup Button
         *
         */
        protected function addHangUpButton():void
        {
            _phoneButtonHangUp = new PhoneButton(PhoneButton.END_CALL);
            _phoneButtonHangUp.x = 560;
            _phoneButtonHangUp.y = 391;
            addChild(_phoneButtonHangUp);
        }

        /**
         * Add the status of the phone
         *
         * @param    status
         */
        protected function addPhoneStatus(status:String = "disconnected"):void
        {
            _phoneStatus = new PhoneStatus(status);
            _phoneStatus.x = 390;
            _phoneStatus.y = 329;
            addChild(_phoneStatus);
        }

        /**
         * Add the default background of phone dialogue
         *
         */
        protected function addDialogueBackground():void
        {
            //first draw bg
            _dialogueBg = new Image(PhoneDialogueAssets.getTexture("PhoneDialogueBackground"));
            addChild(_dialogueBg);
        }

        /**
         * Add Reception (Average by default)
         *
         * @param    reception
         */
        protected function addReception(reception:String = "average"):void
        {
            _reception = new PhoneReception(reception);
            _reception.x = 390;
            _reception.y = 160;
            addChild(_reception);
        }

        protected function addConversationTimer(setTime:String = "00:00"):void
        {
            _convoTimer = new TextField(140, 60, setTime, "Arial", 34, 0xFFFFFF, true);
            _convoTimer.x = 390;
            _convoTimer.y = 100;
            addChild(_convoTimer);
        }

        protected function secondsToHMS(seconds:Number):String
        {
            var s:Number = seconds % 60;
            var m:Number = Math.floor((seconds % 3600 ) / 60);
            var h:Number = Math.floor(seconds / (60 * 60));
            var hourStr:String = (h == 0) ? "" : doubleDigitFormat(h) + ":";
            var minuteStr:String = doubleDigitFormat(m) + ":";
            var secondsStr:String = doubleDigitFormat(s);
            return hourStr + minuteStr + secondsStr;
        }

        protected function doubleDigitFormat($num:uint):String
        {
            if ($num < 10) {
                return ("0" + $num);
            }
            return String($num);
        }

        protected function enablePhoneButton(button:PhoneButton):void
        {
            button.enableButton();
        }

        protected function disablePhoneButton(button:PhoneButton):void
        {
            button.disableButton();
        }

        private function whenStoppedSpeakingHandler(e:flash.events.Event):void
        {
            trace(_messageCounter);
            _currentVoiceFile = null;
            handlePhoneConversationIterator();
        }
		
		override protected function addPlaques(leftPlaque:String = "private", rightPlaque:String = "private", additionalRightPlaque:String = '', secondAdditionalRightPlaque:String = ''):void 
		{
			super.addPlaques(leftPlaque, rightPlaque, additionalRightPlaque, secondAdditionalRightPlaque);
			
			if (_currentState === AWAITING_PHONE_ANSWER) {
				// Add a overlay before they answer
				addPlaqueCalling();
			}
		}
		
		protected function addPlaqueCalling(name:String = 'CHARACTER'):void 
		{
			plaqueStatus = new PlaqueStatus(name, PlaqueStatus.CALLING);
			plaqueStatus.x = PLAQUE_STATUS_RIGHT_X;
			plaqueStatus.y = PLAQUE_Y;
			addChild(plaqueStatus);
		}
		
		protected function addPlaqueDisconnected():void
		{
			plaqueStatus = new PlaqueStatus(name, PlaqueStatus.ENDED);
			plaqueStatus.x = PLAQUE_STATUS_RIGHT_X;
			plaqueStatus.y = PLAQUE_Y;
			addChild(plaqueStatus);
		}
		
		public function hideOverlay():void
		{
			plaqueStatus.hideAndRemove();
		}
    }
}