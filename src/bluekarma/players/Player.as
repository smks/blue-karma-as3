package players
{
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Quad;
    import starling.display.Sprite;
    import FrameSprite;
    import starling.events.Event;

    import videos.IntroVideo;

    import com.greensock.TweenLite;

    import assets.PlayerAssets;

    import states.GameState;

    /**
     * @author Shaun Stone
     */
    public class Player extends FrameSprite
    {
        //set direction constants
        public static const DIRECTION_LEFT:String = "LEFT";
        public static const DIRECTION_RIGHT:String = "RIGHT";
        public static const DIRECTION_UP:String = "UP";
        public static const DIRECTION_DOWN:String = "DOWN";
        //set label constants for movieclips
        public const PLAYER_STAND_RIGHT:uint = 1;
        public const PLAYER_STAND_LEFT:uint = 1;
        public const PLAYER_STAND_UP:uint = 2;
        public const PLAYER_STAND_DOWN:uint = 0;
        //determines if the player is in a specific state
        private const PLAYER_STANDING:String = "STANDING";
        private const PLAYER_WALKING:String = "WALKING";
        private const PLAYER_PICKING_UP:String = "PICKING_UP";
        private const PLAYER_TALKING:String = "TALKING";
        private const PLAYER_IN_MENU:String = "IN_MENU";
        //player state ^^
        public var playerWidth:int;
        public var playerHeight:int;
        protected var playerState:String;
        /**
         * Variables
         */

        //movieclip for player ref
        private var player_stand:MovieClip;
        //Frame sprite class to contain all movieclips as frames
        private var player_walk:MovieClip;
        //attributes of player objects
        private var player_pickup_floor:MovieClip;
        private var player:FrameSprite = new FrameSprite();
        private var xPos:Number;
        private var yPos:Number;
        private var scale:Number;
        private var targetWalkX:Number;
        private var speedX:uint = 3;
        private var quad:Quad;
        //used for debuggin (remove)
        public function Player(fps:uint = 60)
        {
            super(fps);
            this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        private var _direction:String;
        public function get direction():String
        {
            return this._direction;
        }

        public function set direction(value:String):void
        {
            this._direction = value;
        }

        public function stand(dir:String):void
        {

            //go to player_stand movieclip
            player.gotoAndStop("player_stand");
            //set the player state to standing
            setPlayerState(PLAYER_STANDING);
            //determine what direction to stand facing
            switch (dir) {
                case DIRECTION_DOWN :
                    player_stand.currentFrame = PLAYER_STAND_DOWN;
                    setDirection(DIRECTION_DOWN);
                    break;
                case DIRECTION_UP:
                    player_stand.currentFrame = PLAYER_STAND_UP;
                    setDirection(DIRECTION_UP);
                    break;
                case DIRECTION_LEFT :
                    player_stand.currentFrame = PLAYER_STAND_LEFT;
                    setDirection(DIRECTION_LEFT);
                    break;
                case DIRECTION_RIGHT :
                    player_stand.currentFrame = PLAYER_STAND_RIGHT;
                    setDirection(DIRECTION_RIGHT);
                    break;
            }
        }

        public function pickUpFloor():void
        {
            trace("direction in pickup is" + getDirection())
            //set player state to picking up item
            setPlayerState(PLAYER_PICKING_UP);
            //restart animation
            player_pickup_floor.currentFrame = 1;
            //animate crouching to pickup item
            player.gotoAndStop("player_pickup_floor");
            player_pickup_floor.addEventListener(Event.COMPLETE, finishedPickup);
        }

        public function walk(_direction:String, targetPos:Number):void
        {
            //if the player is currently standing
            if (this.playerState == PLAYER_STANDING && this.playerState != PLAYER_PICKING_UP) {

                //set to walking state
                setPlayerState(PLAYER_WALKING);
                //set the direction
                setDirection(_direction);
                //find position to walk to
                this.targetWalkX = targetPos;
                player.gotoAndStop("player_walk");
                this.addEventListener(Event.ENTER_FRAME, walkToPosition);
            }
        }

        /**
         *
         * @param    playerPos
         * @param    targetPos
         */

        public function setDirectionToWalk(playerPos:Number, targetPos:Number):void
        {
            //check what way to walk
            if (playerPos > targetPos) {
                this.setDirection(DIRECTION_LEFT);
            } else if (playerPos < targetPos) {
                this.setDirection(DIRECTION_RIGHT);
            }
        }

        /**
         *
         * @param    playerPos
         * @param    targetPos
         * @param    bgPos
         */

        public function setDirectionFaceObject(playerPos:Number, targetPos:Number, bgPos:uint = 1):void
        {
            var width:Number = stage.stageWidth;
            trace(bgPos + " is the BG POSITION and " + width + " is the width");
            if (bgPos == 2) {
                targetPos -= 853;
            } else if (bgPos == 3) {
                targetPos -= (2560 - stage.stageWidth);
            }
            trace("target pos is now " + targetPos);
            setDirectionToWalk(playerPos, targetPos);
        }

        public function getDirection():String
        {
            return direction;
        }

        //Getters & Setters
        public function setDirection(state:String):void
        {
            if (this.direction != state) {
                if (hasEventListener("walkToPosition")) {
                    trace("this has listener");
                    this.removeEventListener(Event.ENTER_FRAME, walkToPosition);
                }
                if (this.direction == DIRECTION_DOWN || this.direction == DIRECTION_UP) {
                    trace("old up and down");
                    trace("current state is:", state);
                    if (state == DIRECTION_LEFT) {
                        this.direction = DIRECTION_LEFT;
                        player.scaleX = -1;
                        this.x += this.width;
                    } else if (state == DIRECTION_RIGHT) {
                        this.direction = DIRECTION_RIGHT;
                    } else if (state == DIRECTION_UP) {
                        this.direction = DIRECTION_UP;
                        this.scaleX = 1;
                    } else if (state == DIRECTION_DOWN) {
                        this.direction = DIRECTION_UP;
                        this.scaleX = 2;
                    }
                    trace("new state is:", state);
                    trace("new up and down");
                    return;
                } else if (direction == DIRECTION_LEFT) {
                    trace("left");
                    if (state == DIRECTION_RIGHT) {
                        this.direction = DIRECTION_RIGHT;
                        player.scaleX = 1;
                        this.x -= this.width;
                    } else if (state == DIRECTION_UP) {
                        this.direction = DIRECTION_UP;
                        player.scaleX = 1;
                        this.x -= this.width;
                    } else if (state == DIRECTION_DOWN) {
                        this.direction = DIRECTION_DOWN;
                        player.scaleX = 1;
                        this.x -= this.width;
                    }
                    trace("new left");
                    return;
                } else if (direction == DIRECTION_RIGHT) {
                    trace("old right");
                    if (state == DIRECTION_LEFT) {
                        this.direction = DIRECTION_LEFT;
                        player.scaleX = -1;
                        this.x += this.width;
                    } else if (state == DIRECTION_UP) {
                        this.direction = DIRECTION_UP;
                    } else if (state == DIRECTION_DOWN) {
                        this.direction = DIRECTION_DOWN;
                    }
                    trace("new right");
                } else {
                    trace("this.direction is not being set");
                }
            }
        }

        /**
         * set the size of player
         * @param    val
         */

        public function setSize(val:int = 0):void
        {
            if (val == 1) {
                this.scaleX *= 1.4;
                this.scaleY *= 1.4;
            } else {
                this.scaleX = 1;
                this.scaleY = 1;
            }
        }

        public function getXPos():Number
        {
            return this.x;
        }

        public function setXPos(value:Number):void
        {
            this.x = value;
        }

        public function getYPos():Number
        {
            return this.y;
        }

        public function setYPos(value:Number):void
        {
            this.y = value;
        }

        private function onAdded(e:Event):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            //create the player object
            createPlayer();
        }

        private function createPlayer():void
        {
            //allow user more flexibility
            this.touchable = false;
            //create player movieclip for standing
            player_stand = new MovieClip(PlayerAssets.getAtlas().getTextures("riley_stand"), 1);
            this.addChild(player_stand);
            //create player movieclip for walking
            player_walk = new MovieClip(PlayerAssets.getAtlas().getTextures("riley_walk"), 12);
            Starling.juggler.add(player_walk);
            //create player pickup animation
            player_pickup_floor = new MovieClip(PlayerAssets.getAtlas().getTextures("riley_pickup_floor"), 12);
            Starling.juggler.add(player_pickup_floor);
            //add player container
            this.addChild(player);
            //set width and height
            playerWidth = player.width;
            playerHeight = player.height;
            //add movieclips to framesprite container
            player.addFrame("player_stand");
            player.addChildToFrame(player_stand, "player_stand");
            player.addFrame("player_walk");
            player.addChildToFrame(player_walk, "player_walk");
            player.addFrame("player_pickup_floor");
            player.addChildToFrame(player_pickup_floor, "player_pickup_floor");
            //the direction is down by default
            this.direction = DIRECTION_DOWN;
            //make player state stand as default
            setPlayerState(PLAYER_STANDING);
        }

        private function finishedPickup(e:Event):void
        {
            player_pickup_floor.removeEventListener(Event.COMPLETE, finishedPickup);
            //goBack to standing position
            this.stand(DIRECTION_DOWN);
            //dispatch event that item has been picked up
            //dispatchEventWith("addItemToInventory", true);
        }

        private function walkToPosition(e:Event):void
        {
            if (this.direction == DIRECTION_RIGHT) {
                if ((this.x + (this.width / 2)) < this.targetWalkX) {
                    this.x += speedX;
                } else {
                    finishedWalking(DIRECTION_RIGHT);
                }
            } else if (this.direction == DIRECTION_LEFT) {
                if ((this.x - (this.width / 2)) > this.targetWalkX) {
                    this.x -= speedX;
                } else if (this.x < stage.x) {
                    this.x = stage.x;
                    finishedWalking(DIRECTION_UP);
                } else {
                    finishedWalking(DIRECTION_LEFT);
                }
            } else {
                finishedWalking(DIRECTION_DOWN);
            }
        }

        private function finishedWalking(dir:String):void
        {
            trace("finished walking function called");
            //remove event listener
            this.removeEventListener(Event.ENTER_FRAME, walkToPosition);
            //make player stand in direction chosen
            this.stand(dir);
            //check if an event is being listened to
            if (parent.hasEventListener("walkComplete")) {
                trace("finished walking event dispatched");
                parent.dispatchEventWith("walkComplete");
            }
        }

        private function setPlayerState(val:String):void
        {
            this.playerState = val;
        }
    }
}