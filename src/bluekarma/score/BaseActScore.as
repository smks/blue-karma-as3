package score
{
    import adobe.utils.CustomActions;
	import apis.interfaces.ThirdParty;
	import apis.ThirdPartyAPI;

    import global.Global;

    /**
     * ...
     * @author @shaun
     */
    public class BaseActScore
    {
        public const TYPE_MAIN:String = 'main';
        public const TYPE_BONUS:String = 'bonus';
        protected var bonusScore:*;
        protected var currentAct:String;
        protected var actScore:Number = 0;
        protected var achievementsList:Array = new Array();
        protected var achievementsBonusList:Array = new Array();
		protected var api:ThirdPartyAPI;

        public function BaseActScore(api:ThirdPartyAPI)
        {
            this.api = api;
			trace("instantiated score for: " + currentAct);
        }

        /**
         *
         * @param achievement
         * @param score
         * @param achievementDescription
         * @param type
         */
        public function addToScore(achievement:String, score:uint, achievementDescription:String, type:String = 'main'):void
        {
            trace("--- ADDING SCORE ---");
            trace("Achievement: " + achievement);
            trace("Score: " + score);
            trace("Type: " + type);
            trace("--- END OF SCORE ---");

            var dupe:Boolean = false;
            if (type === TYPE_MAIN) {
                achievementsList.push(achievementDescription);
                if (Global.removeDuplicates(achievementsBonusList)) {
                    dupe = true;
                }
            }
            if (type === TYPE_BONUS) {
                achievementsBonusList.push(achievementDescription);
                if (Global.removeDuplicates(achievementsBonusList)) {
                    dupe = true;
                }
            }
            if (dupe === true) {
				return;
            }
			
			actScore += score;
			
			// Unlock Medal with 3rd Party API
			this.api.unlockMedal(achievement);
        }

        public function removeFromScore(score:uint):void
        {
            actScore -= score;
        }

        public function getActScore():Number
        {
            return actScore;
        }

        public function getMainAchievements():Array
        {
            return achievementsList;
        }

        public function getBonusAchievements():Array
        {
            return achievementsBonusList;
        }
    }
}