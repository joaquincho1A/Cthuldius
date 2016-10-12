package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
/**
 * ...
 * @author ...
 */
class BaseEnemies extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		scale.x = 0.7;
		scale.y = 0.7;
		kill();
	}
	override public function update(elapsed:Float):Void
	{
		move();
		
		
		if (this.x > (FlxG.camera.scroll.x + FlxG.camera.width + this.width*2) && this.alive)
			destroy();
		else if (this.x < (FlxG.camera.scroll.x - this.width * 2) && this.alive)
			destroy();
		
	}
	public function move(){};
}