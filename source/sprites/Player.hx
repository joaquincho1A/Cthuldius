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
	private var puedeDisparar:Bool;
	private var counterDisparos:Int;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(32, 32);
		puedeDisparar = true;
		counterDisparos = 0;
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
		if (FlxG.keys.pressed.SPACE && puedeDisparar)
		{
			Reg.arrDisparo.push(new Disparo(this.x + 32, this.y));
			FlxG.state.add(Reg.arrDisparo[Reg.arrDisparo.length - 1]);
			puedeDisparar = false;
			counterDisparos = 0;
		}
		if (!puedeDisparar)
			counterDisparos++;
		if (counterDisparos == 10)
			puedeDisparar = true;
		if (y > (FlxG.height - this.height))
			y = (FlxG.height - this.height)
		else if (y < 0)
			y = 0;
	}
}