package score
{
    import adobe.utils.CustomActions;
	import apis.ThirdPartyAPI;

    import global.Global;

    import mx.utils.ArrayUtil;

    /**
     * ...
     * @author @shaun
     */
    public class LevelOneScore
    {
        private var act1Score:Act1Score;
        private var act2Score:Act2Score;
        private var act3Score:Act3Score;
        private var act4Score:Act4Score;
        private var act5Score:Act5Score;
        private var totalScore:Number = 0;
        private var mainAchievements:Array = new Array();
        private var bonusAchievements:Array = new Array();
        private var api:ThirdPartyAPI;

        /**
         * @param api
         */
        public function LevelOneScore(_api:ThirdPartyAPI)
        {
            this.api = _api;
            act1Score = new Act1Score(api);
            act2Score = new Act2Score(api);
            act3Score = new Act3Score(api);
            act4Score = new Act4Score(api);
            act5Score = new Act5Score(api);
        }

        public function getAct1():Act1Score
        {
            return act1Score;
        }

        public function getAct2():Act2Score
        {
            return act2Score;
        }

        public function getAct3():Act3Score
        {
            return act3Score;
        }

        public function getAct4():Act4Score
        {
            return act4Score;
        }

        public function getAct5():Act5Score
        {
            return act5Score;
        }

        public function getTotalScore():Number
        {
            var totalScr:Number = 0;
            totalScr += getAct1().getActScore();
            totalScr += getAct2().getActScore();
            totalScr += getAct3().getActScore();
            totalScr += getAct4().getActScore();
            totalScr += getAct5().getActScore();
			
			if (totalScr < 0) {
				totalScr = 0;
			}
			
            if (this.totalScore === totalScr) {
                return this.totalScore;
            }
            this.totalScore = totalScr;
            return totalScr;
        }

        public function getMainAchievements():Array
        {
            var arr:Array = new Array();
            arr = Global.mergeArrays(arr, getAct1().getMainAchievements());
            arr = Global.mergeArrays(arr, getAct2().getMainAchievements());
            arr = Global.mergeArrays(arr, getAct3().getMainAchievements());
            arr = Global.mergeArrays(arr, getAct4().getMainAchievements());
            arr = Global.mergeArrays(arr, getAct5().getMainAchievements());
            this.mainAchievements = arr;
            return mainAchievements;
        }

        public function getBonusAchievements():Array
        {
            var arr:Array = new Array();
            arr = Global.mergeArrays(arr, getAct1().getBonusAchievements());
            arr = Global.mergeArrays(arr, getAct2().getBonusAchievements());
            arr = Global.mergeArrays(arr, getAct3().getBonusAchievements());
            arr = Global.mergeArrays(arr, getAct4().getBonusAchievements());
            arr = Global.mergeArrays(arr, getAct5().getBonusAchievements());
            this.bonusAchievements = arr;
            return bonusAchievements;
        }
    }
}