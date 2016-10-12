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
	private var tipo:Int;
	public function new(_tipo:Int,?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(4, 4);
		tipo = _tipo;
		
		switch(tipo)
		{
			case 1:
				{
					velocity.x = 300;
					color = 0xFF0000;
				}
			case 2:
				{
					velocity.x = 300;
					velocity.y = 300;
					color = 0x00FF00;
				}
		}
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (this.x > FlxG.camera.scroll.x + FlxG.camera.width)
			destroy();
	}
}