package settings.base
{
    import settings.AbstractSetting;

    /**
     * @author Shaun Stone
     */
    public class Foreground extends AbstractSetting
    {
        /**
         * @param position
         */
        public function Foreground(position:uint = 1)
        {
            // call parent
            super(position);
            // foregrounds should always be not touchable
            this.touchable = false;
        }
    }
}