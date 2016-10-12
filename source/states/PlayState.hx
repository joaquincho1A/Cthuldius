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
import sprites.Enemy4;
import sprites.Player;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import sprites.PowerUp;

class PlayState extends FlxState
{
	private var tilemap:FlxTilemap;
	private var tilemap2:FlxTilemap;
	private var player:Player;
	private var fondo:FlxSprite;
	
	
	private function entityCreator(name:String, data:Xml):Void
	{
		var startX:Float = Std.parseFloat(data.get("x"));
		var startY:Float = Std.parseFloat(data.get("y"));
		var indice:Int  = Std.parseInt(data.get("id"));
		
		switch (name)
		{
			case "medusa":
					Reg.enemiesGroup.add(new Enemy1(startX, startY));
			case "tiburon":
					Reg.enemiesGroup.add(new Enemy2(startX, startY));
			case "tortuga":
				    Reg.enemiesGroup.add(new Enemy3(startX, startY));
			case "cangrejo":
					Reg.enemiesGroup.add(new Enemy4(startX, startY));
		}
	}
	
	private function spawnEnemies():Void
	{
		for (i in 0...Reg.enemiesGroup.length) 
		{
			if (!Reg.enemiesGroup.members[i].alive) 
			{
				if (Reg.enemiesGroup.members[i].x <= (FlxG.camera.scroll.x + FlxG.camera.width + Reg.enemiesGroup.members[i].width))
				Reg.enemiesGroup.members[i].revive();
			}
		}
	}
	
	
	override public function create():Void
	{
		var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.oceantile__oel);
		tilemap = loader.loadTilemap(AssetPaths.Oceantileset__png, 16, 16, "tileset");
		tilemap2 = loader.loadTilemap(AssetPaths.fondo__png, 75, 240, "fondo");
		
		
		add(tilemap2);
		add(tilemap);
		player = new Player(10,100);
		add(player);
		super.create();
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.NONE);
		tilemap.setTileProperties(2, FlxObject.ANY);
		for (i in 3...20) 
			tilemap.setTileProperties(i, FlxObject.ANY);			

		FlxG.worldBounds.set(0, 0, tilemap.width, tilemap.height);
		FlxG.camera.setScrollBounds(0, tilemap.width, 0, tilemap.height);
		
		loader.loadEntities(entityCreator, "entidades");
		
		Reg.powerUpGroup.add(new PowerUp(10,30));
		Reg.powerUpGroup.add(new PowerUp(50,30));
		Reg.powerUpGroup.add(new PowerUp(100,30));
		Reg.powerUpGroup.add(new PowerUp(150,30));
		Reg.powerUpGroup.add(new PowerUp(200,30));
		
		add(Reg.powerUpGroup);
		add(Reg.enemiesGroup);
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.camera.scroll.x += 1;
		spawnEnemies();
		
		for (l in 0...Reg.enemiesGroup.length) 
		{
			if (FlxG.overlap(player.getShield(), Reg.enemiesGroup.members[l]))
			{
				player.daniarShield();
				Reg.enemiesGroup.members[l].destroy();
			
			}
			if (FlxG.collide(Reg.enemiesGroup.members[l], player))
			{
			trace("choco con enemigo"+l);
			player.destroy();
			}
		}
		//if (FlxG.overlap(Reg.enemiesGroup, player))
		//{
			//trace("choco con enemigo");
			//player.destroy();
		//}
		if (FlxG.collide(tilemap, player))
		{
			trace("choco con tilemap");
			player.destroy();
		}
		for (i in 0...Reg.disparoGroup.length)
			if (FlxG.collide(tilemap, Reg.disparoGroup.members[i]))
				Reg.disparoGroup.members[i].destroy();
		for (i in 0...Reg.disparoGroup.length)
		{
			for (j in 0...Reg.enemyDisparoGroup.length)
			{
				if (FlxG.collide(Reg.disparoGroup.members[i], Reg.enemyDisparoGroup.members[j]))
				{	
					Reg.disparoGroup.members[i].destroy();
					Reg.enemyDisparoGroup.members[j].destroy();
				}
			}
		}
		for (i in 0...Reg.enemyDisparoGroup.length)
			if (FlxG.collide(tilemap, Reg.enemyDisparoGroup.members[i]))
				Reg.enemyDisparoGroup.members[i].destroy();
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
		for (k in 0...Reg.powerUpGroup.length) 
		{
			if (FlxG.overlap(player,Reg.powerUpGroup.members[k])) 
			{
				Reg.powerUpGroup.members[k].destroy();
				player.agarroPowerUp();
			}
		}
	}
}
