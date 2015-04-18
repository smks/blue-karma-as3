package interfaces
{
    /**
     * ...
     * @author Shaun Stone
     */
    public interface IPlayer
    {
        function stand(direction:String):void;

        function movePlayerPosition(xPos:int, yPos:int, direction:String):void;

        function walkTo(direction:String, targetPos:Number):void;

        function setPlayerState(state:String):void;

        function getDirection():String;

        function setDirectionToTarget(playerPos:Number, targetPos:Number, bgPosition:uint = 1, bgWidth:uint = 1024):void

        function setDirection(direction:String):void;

        function setSize(val:Number = 1):void;

        function addPositionOffset(offset:Boolean):void;

        function pickupItem():void;

        function playerWalkCheck(_xPos:int, _yPos:int, bgPos:uint, boundaryUp:int, boundaryDown:int, boundaryLeft:int, boundaryRight:int):void
    }
}