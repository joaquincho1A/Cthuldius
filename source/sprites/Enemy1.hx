package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;

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
		
	}
	override public function move() 
	{
		super.move();
		if (etapa == 1)
		{
			y--;
			x--;
			movimiento++;
		}
		else if (etapa == 2)
		{
			y++;
			x--;
			movimiento++;
		}
		
		else if (etapa == 3)
		{
			y++;
			x++;
			movimiento++;
		}
		else if (etapa == 4)
		{
			y--;
			x++;
			movimiento++;
		}
		//if (etapa == 1)
		//{
			//x--;
			//movimiento++;
		//}
		//else if (etapa == 2)
		//{
			//
			//y++;
			//movimiento++;
		//}
		//else if (etapa == 3)
		//{
			//x += 3;
			//movimiento++;
		//}
		if (movimiento == 50)
		{
			etapa++;
			if (etapa == 5)
				etapa = 1;
			movimiento = 0;
		}
		trace(movimiento);
	}
}