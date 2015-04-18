package apis.interfaces 
{
	import flash.display.Stage;
	
	/**
	 * @author Shaun Stone
	 */
	public interface ThirdParty 
	{
		function connect():void
		function disconnect():void
		
		/**
		 * Post Final Score of Level
         * @param score
		 * @return bool
		 */
		function postScore(score:int):void

        /**
         * Post Final Time of Level
         * @param milliseconds
         * @return bool
         */
        function postTime(milliseconds:int):void

		/**
		 * Unlock a medal by name
		 * @param name
		 * @return bool
		 */
		function unlockMedal(name:String):void
		
		/**
		 * Some APIs may need the stage for ref
		 * @return
		 */
		function requiresStage():Boolean
		function setStage(stage:Stage):void
	}
	
}