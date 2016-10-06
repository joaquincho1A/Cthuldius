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
		
		/*var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.level1__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 16, 16, "tiles");
		
		add(tilemap);*/
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
