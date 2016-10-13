package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Enemy1 extends BaseEnemies
{
	var etapa:Int = 1;
	var movimiento:Int = 0;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		//makeGraphic(16, 16);
		loadGraphic(AssetPaths.Medusa__png, true, 32, 32);
		animation.add("idle", [0, 1], 4, true);
		animation.play("idle");
		//scale.x = 0.5;
		//scale.y = 0.5;
		//updateHitbox();
	}
	override public function move() 
	{
		super.move();
		if (etapa == 1)
		{
			x -=1;
			movimiento++;
		}
		else if (etapa == 2)
		{
			y++;
			x++;
			movimiento++;
		}
		
		else if (etapa == 3)
		{
			x+=2;
			movimiento++;
		}

		if (movimiento == 80 && etapa == 1)
		{
			etapa++;
			movimiento = 0;
		}
		else if (movimiento == 50 && etapa == 2)
		{
			etapa++;
			movimiento = 0;
		}
	}
}