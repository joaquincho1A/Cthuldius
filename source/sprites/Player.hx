package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Player extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(32,32);
		
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.keys.pressed.LEFT)
			x -= 150 * FlxG.elapsed;
		if (FlxG.keys.pressed.RIGHT)
			x += 150 * FlxG.elapsed;
		if (FlxG.keys.pressed.UP)
			y -= 150 * FlxG.elapsed;
		if (FlxG.keys.pressed.DOWN)
			y += 150 * FlxG.elapsed;
		if (FlxG.keys.pressed.SPACE)
			Reg.disparo = new Disparo();
			Reg.disparo.x = this.x + 32;
			Reg.disparo.y = this.y;
			FlxG.state.add(Reg.disparo);
		if (y > (FlxG.height - this.height))
			y = (FlxG.height - this.height)
			else if (y < 0)
				y = 0;
	}
}