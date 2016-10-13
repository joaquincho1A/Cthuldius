package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
/**
 * ...
 * @author ...
 */
class Barriles extends FlxSprite
{
	private var destruido:Bool;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		//makeGraphic(18, 22,0xFF00FF00);
		loadGraphic(AssetPaths.Barril__png, false, 18, 22);
		destruido = false;
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		velocity.x = -60;
		angle += 5;
		updateHitbox();
		if (this.x > (FlxG.camera.scroll.x + FlxG.camera.width + this.width*2) && this.alive)
			kill();
		else if (this.x < (FlxG.camera.scroll.x - this.width * 2) && this.alive)
			kill();
			for (i in 0...Reg.disparoGroup.length) 
			{
				if (FlxG.overlap(this, Reg.disparoGroup.members[i]))
				{
					Reg.disparoGroup.members[i].destroy();
					destruido = true;
					kill();
				}
			}

	}
	public function getDestruido():Bool
	{
		return destruido;
	}
}