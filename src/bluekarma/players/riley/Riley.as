package players.riley
{
    import assets.PlayerAssets;
    import FrameSprite;
    import players.AbstractPlayer;

    import starling.display.DisplayObject;
    import starling.display.MovieClip;
    import starling.events.Event;
    import starling.core.Starling;

    import flash.utils.Dictionary;

    /**
     * ...
     * @author Shaun Stone
     */
    public class Riley extends AbstractPlayer
    {		
        public function Riley(_fps:Number = 12)
        {
            super(_fps);
        }

        override protected function drawPlayer():void
        {
            //sets up the player object
            setupPlayerSpriteFrames();
            // by default make player stand towards screen
            _player.gotoAndStop(PLAYER_STAND_DOWN);
            //make player state stand as default
            setPlayerState(PLAYER_STANDING_STATE);
            //the direction is down by default
            setDirection(DIRECTION_DOWN);
        }

        override public function walkTo(direction:String, targetPos:Number):void
        {
            //if the player is currently standing
            if (this._playerState == PLAYER_STANDING_STATE) {
                //set to walking state
                setPlayerState(PLAYER_WALKING_STATE);
                //set the direction
                setDirection(direction);
                //pass global target position
                _targetWalkX = targetPos;
                //change to walking animation
                _player.gotoAndStop(PLAYER_WALK);
                //add enter frame to walk path
                this.addEventListener(Event.ENTER_FRAME, walkToPosition);
            }
        }

        /**
         *
         * @param    xPos
         * @param    yPos
         * @param    scale
         */
        override protected function addPlayer(xPos:int = 0, yPos:int = 0, scale:Number = 1):void
        {
            _player = new Riley;
            _player.x = xPos;
            _player.y = yPos;
            _player.scaleX = scale;
            _player.scaleY = scale;
            addChild(_player);
        }

        override protected function finishedWalking(direction:String):void
        {
            //remove event listener
            this.removeEventListener(Event.ENTER_FRAME, walkToPosition);
            //make player stand in direction chosen
            stand(direction);
        }

        override public function pickupItem():void
        {
            setPlayerState(PLAYER_PICKING_UP_STATE);
            //when done call finishedPickup
            finishedPickup();
        }

        protected function setupPlayerSpriteFrames():void
        {
            //instantiate new framesprite container
            _player = new FrameSprite();
            //instantiate all moviclip frames to use in framesprite
            createPlayerFrames();
            //add movieclips to framesprite container
            _player.addFrame(PLAYER_STAND_UP);
            _player.addChildToFrame(_playerStandUp, PLAYER_STAND_UP);
            _player.addFrame(PLAYER_STAND_DOWN);
            _player.addChildToFrame(_playerStandDown, PLAYER_STAND_DOWN);
            _player.addFrame(PLAYER_STAND_SIDE);
            _player.addChildToFrame(_playerStandSide, PLAYER_STAND_SIDE);
            _player.addFrame(PLAYER_WALK);
            _player.addChildToFrame(_playerWalk, PLAYER_WALK);
            _player.addFrame(PLAYER_PICKING_UP);
            _player.addChildToFrame(_playerPickupItem, PLAYER_PICKING_UP);
            //add player container
            addChild(_player);
        }

        protected function createPlayerFrames():void
        {
            //Create player movieclip for standing facing the screen
            _playerStandDown = new MovieClip(PlayerAssets.getAtlas().getTextures("riley_stand_down"), 6);
            _playerStandDown.setFrameDuration(0, 2);
            Starling.juggler.add(_playerStandDown);
            //create player movieclip for standing facing away from screen
            _playerStandUp = new MovieClip(PlayerAssets.getAtlas().getTextures("riley_stand_up"), 6);
            Starling.juggler.add(_playerStandUp);
            //create player movieclip for standing sideways
            _playerStandSide = new MovieClip(PlayerAssets.getAtlas().getTextures("riley_stand_side"), 6);
            _playerStandSide.setFrameDuration(0, 2);
            Starling.juggler.add(_playerStandSide);
            //create player movieclip for walking
            _playerWalk = new MovieClip(PlayerAssets.getAtlas().getTextures("riley_walk"), 36);
            Starling.juggler.add(_playerWalk);
        }

        protected function finishedPickup():void
        {
            //set state back to standing
            setPlayerState(PLAYER_STANDING_STATE);
        }

        private function walkToPosition(e:Event):void
        {
            if (this._playerState != PLAYER_WALKING_STATE) {
                return;
            }
            switch (_direction) {
                case DIRECTION_RIGHT:
                    if ((this.x + (this.width / 2)) < _targetWalkX) {
						moveRight();
                    }
                    else if (this.x > stage.x) {
                        //this.x = stage.x;
                        finishedWalking(DIRECTION_RIGHT);
                    }
                    else {
                        finishedWalking(DIRECTION_RIGHT);
                    }
                    break;
                case DIRECTION_LEFT:
                    if ((this.x - (this.width / 2)) > _targetWalkX) {
						moveLeft();
                    }
                    else if (this.x < stage.x) {
                        this.stage.x;
                        finishedWalking(DIRECTION_LEFT);
                    }
                    else {
                        finishedWalking(DIRECTION_LEFT);
                    }
                    break;
            }
        }
		
		private function moveLeft():void 
		{
			this.x -= _speedX;
		}
		
		private function moveRight():void 
		{
			this.x += _speedX;
		}
    }
}