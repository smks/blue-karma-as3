package interfaces
{
    import starling.events.Event;
    import starling.events.TouchEvent;

    import events.InteractionEvent;

    /**
     * ...
     * @author Shaun Stone
     */
    public interface ILevel
    {
        function changeBackground():void;

        function getClockTime():String;

        function addGradientOverlay():void;

        function drawLevel():void;

        function createNavigationArrows():void;

        function addNavigationArrows():void;

        function addInventory():void;

        function addPlayer(xPos:int = 0, yPos:int = 0, scale:Number = 1):void;

        function playerInteraction(allow:Boolean = false):void;

        function addBackground():void;

        function addForeground():void;

        function goToBackgroundPosition(e:Event):void;

        function setWalkingBoundaries():void;

        function positionDecisionWheelX(xPos:int):int;

        function positionDecisionWheelY(yPos:int):int;

        function displayCorrectNavigationArrows(bgPosition:uint):void;

        function initializeLevel():void;

        function touchInteractionHandler(event:TouchEvent):void;

        function interactionHandler(event:InteractionEvent):void;

        function onInteractionComplete(e:Event):void;

        function createDecisionWheel(object:Object):void;

        function proceedWithDecision(e:Event):void;

        function actionObject(name:String, type:String):void;

        function chatObject(name:String, type:String):void;

        function examineObject(name:String, type:String):void;
    }
}