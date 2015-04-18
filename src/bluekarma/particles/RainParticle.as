package particles
{
    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.extensions.Particle;

    import assets.ParticleAssets;

    import starling.extensions.ParticleSystem;
    import starling.extensions.PDParticleSystem;
    import starling.textures.Texture;

    /**
     * ...
     * @author Shaun Stone
     */
    public class RainParticle extends Sprite
    {
        [Embed(source="../../../media/particles/particle.pex", mimeType="application/octet-stream")]
        private static const RainConfig:Class;
        [Embed(source="../../../media/particles/rain.png")]
        private static const RainParticleTexture:Class;

        public function RainParticle()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        private function onAdded(e:Event):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            //create particle
            var rainConfig:XML = XML(new RainConfig());
            var rainTexture:Texture = Texture.fromBitmap(new RainParticleTexture());
            var rainParticleSystem:PDParticleSystem = new PDParticleSystem(rainConfig, rainTexture);
            //add to stage
            this.addChild(rainParticleSystem);
            rainParticleSystem.emitterX = 0;
            rainParticleSystem.emitterY = 0;
            rainParticleSystem.start();
            Starling.juggler.add(rainParticleSystem);
        }
    }
}