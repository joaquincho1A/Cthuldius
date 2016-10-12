package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;

class MenuState extends FlxState
{
	/*private var player:FlxSprite;
	private var tilemap:FlxTilemap;*/
	
	override public function create():Void
	{
		super.create();
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.keys.pressed.SPACE)
		{
			FlxG.switchState(new PlayState());
		}
	}
}
