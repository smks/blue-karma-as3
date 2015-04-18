package players
{
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Quad;
    import starling.display.Sprite;
    import FrameSprite;
    import starling.events.Event;

    import com.greensock.TweenLite;

    import assets.PlayerAssets;

    import states.GameState;

    import interfaces.IPlayer;

    import flash.utils.Dictionary;

    /**
     * @author Shaun Stone
     */
    public class AbstractPlayer extends FrameSprite implements IPlayer
    {
        //set direction constants
        public static const DIRECTION_LEFT:String = "left";
        public static const DIRECTION_RIGHT:String = "right";
        public static const DIRECTION_UP:String = "up";
        public static const DIRECTION_DOWN:String = "down";
        public const POSITION_LEFT:String = "left_position";
        public const POSITION_RIGHT:String = "right_position";
        public const POSITION_LOWER_CENTER:String = "lower_center_position";
        public const POSITION_UPPER_CENTER:String = "upper_center_position";
        //set label constants for movieclips
        public const PLAYER_STAND_UP:String = "player_stand_up";
        public const PLAYER_STAND_DOWN:String = "player_stand_down";
        //default looking right (only one frame needed for walk and stand side)
        public const PLAYER_STAND_SIDE:String = "player_stand_side";
        public const PLAYER_WALK:String = "player_walk";
        public const PLAYER_PICKING_UP:String = "player_picking_up";
        public const PLAYER_STANDING_STATE:String = "standing";
        public const PLAYER_WALKING_STATE:String = "walking";
        public const PLAYER_PICKING_UP_STATE:String = "picking_up";
        public const PLAYER_TALKING_STATE:String = "talking";
        public const PLAYER_IN_MENU_STATE:String = "in_menu";
        //player state (states above ^^)
        public var playerWidth:int;
        //determines whether to -1 scaleX for player
        public var playerHeight:int;
        //Frame sprite class to contain all movieclips as frames
        protected var _playerState:String;
        //movieclip for player ref
        protected var _playerOffset:Boolean = false;
        protected var _player:FrameSprite;
        protected var _playerStandUp:MovieClip;
        protected var _playerStandDown:MovieClip;
        protected var _playerStandSide:MovieClip;
        //attributes of player objects
        protected var _playerWalk:MovieClip;
        protected var _playerPickupItem:MovieClip;
        protected var _xPos:Number = 0;
        protected var _yPos:Number = 0;
        protected var _scale:Number;
        protected var _direction:String;
        protected var _targetWalkX:Number;
        protected var _speedX:uint = 3;

        public function AbstractPlayer(_fps:Number = 12)
        {
            super(_fps);
            this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        /**
         *
         * @param direction
         */
        public function stand(direction:String):void
        {

            //go to player_stand movieclip
            _player.gotoAndStop("player_stand");
            //set the player state to standing
            setPlayerState(PLAYER_STANDING_STATE);
            //determine what direction to stand facing
            switch (direction) {
                case DIRECTION_DOWN :
                    _player.gotoAndStop(PLAYER_STAND_DOWN);
                    setDirection(DIRECTION_DOWN);
                    break;
                case DIRECTION_UP :
                    _player.gotoAndStop(PLAYER_STAND_UP);
                    setDirection(DIRECTION_UP);
                    break;
                case DIRECTION_LEFT :
                    _player.gotoAndStop(PLAYER_STAND_SIDE);
                    setDirection(DIRECTION_LEFT);
                    break;
                case DIRECTION_RIGHT :
                    _player.gotoAndStop(PLAYER_STAND_SIDE);
                    setDirection(DIRECTION_RIGHT);
                    break;
            }
        }

        /**
         *
         * @param    xPos
         * @param    yPos
         * @desc     called when bg position is changed, moves player to correct spot
         *             i.e. chooses to walk right, this will move him to left of the screen
         *             of next position at certain point
         */
        public function movePlayerPosition(xPos:int, yPos:int, direction:String):void
        {
            this.stand(direction);
            this.x = xPos;
            this.y = yPos;
        }

        /**
         *
         * @param    direction
         * @param    targetPos
         * @desc will make the target player walk to a target position passed in
         */
        public function walkTo(direction:String, targetPos:Number):void
        {
        }

        public function pickupItem():void
        {
        }

        /**
         *
         * @param    state
         */

        public function setPlayerState(state:String):void
        {
            this._playerState = state;
        }

        public function getPlayerState():String
        {
            return this._playerState;
        }

        /**
         *
         * @return
         */

        public function getDirection():String
        {
            return _direction;
        }

        /**
         *
         * @param    playerPos
         * @param    targetPos
         * @param    bgPosition
         * @param    bgWidth
         */

        public function setDirectionToTarget(playerPos:Number, targetPos:Number, bgPosition:uint = 1, bgWidth:uint = 1024):void
        {
            //playerPos = findPlayerPosition(playerPos, bgPosition, bgWidth);
            if (playerPos > targetPos) {
                this.setDirection(DIRECTION_LEFT);
            } else if (playerPos < targetPos) {
                this.setDirection(DIRECTION_RIGHT);
            }
        }

        /**
         *
         * @param    direction
         */

        public function setDirection(direction:String):void
        {
            if (this._direction != direction) {
                if (this._direction === null) {
                    this._direction = direction;
                }
                switch (this._direction) {

                    //If Direction is Currently looking UP
                    case DIRECTION_UP:
                        switch (direction) {
                            case DIRECTION_LEFT:
                                this._direction = DIRECTION_LEFT;
                                addPositionOffset(true);
                                break;
                            case DIRECTION_RIGHT:
                                this._direction = DIRECTION_RIGHT;
                                addPositionOffset(false);
                                break;
                            case DIRECTION_DOWN:
                                this._direction = DIRECTION_DOWN;
                                addPositionOffset(false);
                                break;
                        }
                        break;

                    //If Direction is Currently looking DOWN
                    case DIRECTION_DOWN:
                        switch (direction) {
                            case DIRECTION_LEFT:
                                this._direction = DIRECTION_LEFT;
                                addPositionOffset(true);
                                break;
                            case DIRECTION_RIGHT:
                                this._direction = DIRECTION_RIGHT;
                                addPositionOffset(false);
                                break;
                            case DIRECTION_UP:
                                this._direction = DIRECTION_UP;
                                addPositionOffset(false);
                                break;
                        }
                        break;

                    //If Direction is Currently looking LEFT
                    case DIRECTION_LEFT:
                        switch (direction) {
                            case DIRECTION_RIGHT:
                                this._direction = DIRECTION_RIGHT;
                                addPositionOffset(false);
                                break;
                            case DIRECTION_UP:
                                this._direction = DIRECTION_UP;
                                addPositionOffset(false);
                                break;
                            case DIRECTION_DOWN:
                                this._direction = DIRECTION_DOWN;
                                addPositionOffset(false);
                                break;
                        }
                        break;

                    //If Direction is Currently looking RIGHT
                    case DIRECTION_RIGHT:
                        switch (direction) {
                            case DIRECTION_LEFT:
                                this._direction = DIRECTION_LEFT;
                                addPositionOffset(true);
                                break;
                            case DIRECTION_UP:
                                this._direction = DIRECTION_UP;
                                addPositionOffset(false);
                                break;
                            case DIRECTION_DOWN:
                                this._direction = DIRECTION_DOWN;
                                addPositionOffset(false);
                                break;
                        }
                        break;
                }
            }
        }

        /**
         *
         * @param _xPos
         * @param _yPos
         * @param bgPos
         * @param boundaryUp
         * @param boundaryDown
         * @param boundaryLeft
         * @param boundaryRight
         */
        public function playerWalkCheck(_xPos:int, _yPos:int, bgPos:uint, boundaryUp:int, boundaryDown:int, boundaryLeft:int, boundaryRight:int):void
        {
            if (_playerState != PLAYER_WALKING_STATE) {

                //check touch is in the necessary boundaries that are walkable
                if (_yPos <= boundaryDown && _yPos >= boundaryUp && _xPos >= boundaryLeft && _xPos <= boundaryRight) {

                    //check direction to walk
                    this.setDirectionToTarget(this.x, _xPos);
                    //walk player to chosen destination
                    this.walkTo(this.getDirection(), _xPos);
                } else if (_yPos > boundaryDown) {

                    //make player look forward
                    this.stand(AbstractPlayer.DIRECTION_DOWN);
                } else if (_yPos < boundaryUp) {

                    //make player look forward
                    this.stand(AbstractPlayer.DIRECTION_UP);
                }
            }
        }

        /**
         *
         * @param offset
         */
        public function addPositionOffset(offset:Boolean):void
        {
            if (!this._playerOffset) {
                if (offset) {
                    this.x += this.width;
                    _player.scaleX = -1;
                    this._playerOffset = true;
                }
            } else {
                if (!offset) {
                    this.x -= this.width;
                    _player.scaleX = 1;
                    this._playerOffset = false;
                }
            }
        }

        /**
         *
         * @param    val
         */
        public function setSize(val:Number = 1):void
        {
            this.scaleX = val;
            this.scaleY = val;
        }

        protected function drawPlayer():void
        {
        }

        protected function finishedWalking(dir:String):void
        {
        }

        /**
         *
         * @param    playerPos
         * @param    bgPosition
         * @return
         */

        protected function findPlayerPosition(playerPos:uint, bgPosition:uint, bgWidth:uint):uint
        {
            switch (bgPosition) {
                case 2:
                    playerPos += bgWidth;
                    break;
                case 3:
                    playerPos += (bgWidth * 2);
                    break;
                case 5:
                    playerPos += bgWidth;
                    break;
                case 6:
                    playerPos += (bgWidth * 2);
                    break;
            }
            return playerPos;
        }

        /**
         *
         * @param xPos
         * @param yPos
         * @param scale
         */
        protected function addPlayer(xPos:int = 0, yPos:int = 0, scale:Number = 1):void
        {
        }

        /**
         *
         * @param    e
         */

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            touchable = false;
            drawPlayer();
        }
    }
}