package sprites;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Enemy3 extends BaseEnemies
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
	}
	override public function move() 
	{
		super.move();
		
		if (y > Reg.posYplayer)
			y--;
		else if (y < Reg.posYplayer)
			y++;
		if (y == Reg.posYplayer)
			x -= 2;
		else
		 x-= 0,5;
		
		
		
		
		
		//if (etapa == 1)
		//{
			//x -=2;
			//movimiento++;
		//}
		//else if (etapa == 2)
		//{
			//y++;
			//x++;
			//movimiento++;
		//}
		//
		//else if (etapa == 3)
		//{
			//x+=3;
			//movimiento++;
		//}
//
		//if (movimiento == 80 && etapa == 1)
		//{
			//etapa++;
			//movimiento = 0;
		//}
		//else if (movimiento == 50 && etapa == 2)
		//{
			//etapa++;
			//movimiento = 0;
		//}
	}
}