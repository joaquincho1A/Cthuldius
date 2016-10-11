package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.system.FlxAssets.FlxGraphicAsset;
import sprites.Enemy1;
import sprites.Enemy2;
import sprites.Enemy3;
import sprites.Player;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;

class PlayState extends FlxState
{
	private var tilemap:FlxTilemap;
	private var player:Player;
	
	override public function create():Void
	{
		var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.level1__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 16, 16, "tiles");
		
		add(tilemap);
		player = new Player();
		add(player);
		super.create();
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.NONE);
		tilemap.setTileProperties(2, FlxObject.ANY);
		FlxG.worldBounds.set(0, 0, tilemap.width, tilemap.height);
		FlxG.camera.setScrollBounds(0, tilemap.width, 0, tilemap.height);
		
		Reg.enemiesGroup.add(new Enemy3(FlxG.camera.scroll.x+FlxG.camera.width, 50));
		//Reg.enemiesGroup.add(new Enemy1(220, 50));
		//Reg.enemiesGroup.add(new Enemy1(240, 50));
		add(Reg.enemiesGroup);
		//var enemi:Enemy1 = new Enemy1(200, 50);
		//add(enemi);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		//FlxG.camera.scroll.x += 1;
		
		if (FlxG.collide(tilemap, player))
			player.destroy();
		
		for (i in 0...Reg.disparoGroup.length) 
		{
			for (j in 0...Reg.enemiesGroup.length) 
			{
				if (FlxG.collide(Reg.disparoGroup.members[i], Reg.enemiesGroup.members[j]))
				{
					Reg.disparoGroup.members[i].destroy();
					Reg.enemiesGroup.members[j].destroy();
				}
			}
		}
	
	}
}
