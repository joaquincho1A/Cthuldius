package sprites;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Disparo extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(4, 4);
		color = 0xFF0000;
		velocity.x = 200;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		//if (FlxG.overlap(this, Reg.enemiesGroup))
			//destroy();
		 if (this.x > FlxG.camera.scroll.x + FlxG.camera.width)
			destroy();
	}
}