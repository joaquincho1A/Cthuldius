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
		loadGraphic(AssetPaths.Tortuga__png, true, 32, 32);
		animation.add("idle", [0, 1], 4, true);
		animation.play("idle");
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
		 x-= 0.5;
	}
}