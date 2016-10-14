package sprites;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class EnemyDisparo extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(4, 4);
		velocity.y =  -200;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		 if (this.y > FlxG.camera.scroll.y + FlxG.camera.height)
			destroy();
	}
}