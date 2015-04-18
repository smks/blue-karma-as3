package players.riley
{
    import assets.PlayerAssets;
    import FrameSprite;
    import players.AbstractPlayer;

    import starling.display.DisplayObject;
    import starling.display.MovieClip;
    import starling.events.Event;
    import starling.core.Starling;

    import flash.utils.Dictionary;

    import starling.textures.TextureAtlas;

    /**
     * @author Shaun Stone
     */
    public class RileyPyjamas extends Riley
    {
        protected const PLAYER_ATLAS:String = "riley_pyjamas";

        public function RileyPyjamas(_fps:Number = 12)
        {
            super(_fps);
        }

        override protected function createPlayerFrames():void
        {
            //Create player movieclip for standing facing the screen
            _playerStandDown = new MovieClip(PlayerAssets.getAtlas(PLAYER_ATLAS).getTextures("riley_stand_down_pyjamas"), 6);
            _playerStandDown.setFrameDuration(0, 4);
            Starling.juggler.add(_playerStandDown);
            //create player movieclip for standing facing away from screen
            _playerStandUp = new MovieClip(PlayerAssets.getAtlas(PLAYER_ATLAS).getTextures("riley_stand_up_pyjamas"), 1);
			_playerStandUp.x += (_playerStandUp.width / 4);
            //create player movieclip for standing sideways
            _playerStandSide = new MovieClip(PlayerAssets.getAtlas(PLAYER_ATLAS).getTextures("riley_stand_side_pyjamas"), 6);
            _playerStandSide.setFrameDuration(0, 4);
            Starling.juggler.add(_playerStandSide);
            //create player movieclip for walking
            _playerWalk = new MovieClip(PlayerAssets.getAtlas(PLAYER_ATLAS).getTextures("riley_walk_pyjamas"), 30);
            _playerWalk.x -= (_playerWalk.width / 4);
            Starling.juggler.add(_playerWalk);
        }
    }
}