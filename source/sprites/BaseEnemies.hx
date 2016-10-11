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
		makeGraphic(10, 10);		
	}
	override public function update(elapsed:Float):Void
	{
		if (this.x > (FlxG.camera.scroll.x + FlxG.camera.width + this.width*2))
			destroy();
		else if (this.x < (FlxG.camera.scroll.x - this.width * 2))
			destroy();
		move();
	}
	public function move(){};
}