package helpers
{
    /**
     * @author @shaun
     */
    public class ScoreCalculator
    {
        private static const LEVEL_1_EXPECTED_TIME:uint = 600;

        /**
         *
         * @param levelScore
         * @param levelTimeSeconds
         * @return
         */
        public static function calculateLevelScore(levelScore:Number, levelTimeSeconds:Number, level:uint = 1):Number
        {
            var calcScore:Number;
            var levelTimeScore:Number = ScoreCalculator.LEVEL_1_EXPECTED_TIME - levelTimeSeconds;
            return levelTimeScore;
        }
    }
}