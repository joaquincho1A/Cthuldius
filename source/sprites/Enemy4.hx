package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Enemy4 extends BaseEnemies
{
	var etapa:Int = 1;
	var movimiento:Int = 0;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(16, 16);
		loadGraphic(AssetPaths.Cangrejo__png, true, 32, 32);
		animation.add("idle", [0, 1], 4, true);
		animation.play("idle");
		if (y < FlxG.camera.height/2)
			flipY = true;
	}
	override public function move() 
	{
		super.move();
		
		if (etapa == 1)
		{
			x --;
			movimiento++;
		}
		else if (etapa == 2)
		{
			x++;
			movimiento++;
		}
		else if (etapa == 3)
		{
			Reg.enemyDisparoGroup.add(new EnemyDisparo(this.x + width / 2, this.y));
			FlxG.state.add(Reg.enemyDisparoGroup);
			etapa = 1;
		}
		if (movimiento == 50 && etapa == 1)
		{
			etapa++;
			movimiento = 0;
		}
		else if (movimiento == 50 && etapa == 2)
		{
			etapa++;
			movimiento = 0;
		}
		else if (movimiento == 2 && etapa == 3)
		{
			movimiento = 0;
		}
		
	}

}