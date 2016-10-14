package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Escudo extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		//makeGraphic(5, 32);
		loadGraphic(AssetPaths.Shield__png);
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		x = Reg.posXplayer + Reg.widthPlayer/2 + 5;
		y = Reg.posYplayer - Reg.heightPlayer/2;
	}
}