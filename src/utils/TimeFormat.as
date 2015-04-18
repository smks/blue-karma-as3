package utils
{
    public class TimeFormat
    {
        public static const HOURS:uint = 2;
        public static const MINUTES:uint = 1;
        public static const SECONDS:uint = 0;

        public static function formatTime(time:Number, detailLevel:uint = 2):String
        {
            var intTime:uint = Math.floor(time);
            var hours:uint = Math.floor(intTime / 3600);
            var minutes:uint = (intTime - (hours * 3600)) / 60;
            var seconds:uint = intTime - (hours * 3600) - (minutes * 60);
            var hourString:String = detailLevel == HOURS ? hours + ":" : "";
            var minuteString:String = detailLevel >= MINUTES ? ((detailLevel == HOURS && minutes < 10 ? "0" : "") + minutes + ":") : "";
            var secondString:String = ((seconds < 10 && (detailLevel >= MINUTES)) ? "0" : "") + seconds;
            return hourString + minuteString + secondString;
        }
    }
}