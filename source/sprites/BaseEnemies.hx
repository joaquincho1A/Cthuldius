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
	private var killed:Bool;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		killed = false;
		kill();
	}
	override public function update(elapsed:Float):Void
	{
		move();
		if (this.x > (FlxG.camera.scroll.x + FlxG.camera.width + this.width*2) && this.alive)
			kill();
		else if (this.x < (FlxG.camera.scroll.x - this.width * 2) && this.alive)
			kill();
	}
	public function move(){};
	public function leDispararon():Void
	{
		killed = true;
	}
	public function checkKilled():Bool
	{
		return killed;
	}
}
