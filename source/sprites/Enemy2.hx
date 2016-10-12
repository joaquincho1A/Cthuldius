package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Enemy2 extends BaseEnemies
{
	var etapa:Bool = true;
	var movimiento:Int = 0;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		loadGraphic(AssetPaths.Tiburon2__png, true, 32, 13);
		animation.add("idle", [0, 1], 4, true);
		animation.play("idle");
	}
	override public function move() 
	{
		super.move();
		x --;
		if (etapa)
		{
			y -= 2;
			movimiento++;
		}
		else if (!etapa)
		{
			y += 2;
			movimiento++;
		}

		if (movimiento == 20)
		{
			etapa = !etapa;
			movimiento = 0;
		}
	}
}