package states;

import flash.media.Video;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.system.FlxAssets.FlxGraphicAsset;
import sprites.Boss;
import sprites.Enemy1;
import sprites.Enemy2;
import sprites.Enemy3;
import sprites.Enemy4;
import sprites.Player;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import sprites.PowerUp;
import flixel.group.FlxGroup.FlxTypedGroup;
import sprites.BaseEnemies;
import sprites.Disparo;
import sprites.EnemyDisparo;
import sprites.Barriles;


class PlayState extends FlxState
{
	private var tilemap:FlxTilemap;
	private var tilemap2:FlxTilemap;
	private var player:Player;
	private var fondo:FlxSprite;
	private var boss:Boss;
	private var textoScore:FlxText;
	private var disparoAux:Disparo;
	
	private function hudUpdate():Void
	{
		textoScore.text = Std.string(Reg.score);
		textoScore.x += 1;
		
		
	}
	
	
	private function entityCreator(name:String, data:Xml):Void
	{
		var startX:Float = Std.parseFloat(data.get("x"));
		var startY:Float = Std.parseFloat(data.get("y"));

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
			case "jefe":
					boss = new Boss(startX, startY);
		}
	}
	private function spawnEnemies():Void
	{
		for (i in 0...Reg.enemiesGroup.length) 
		{
			if (!Reg.enemiesGroup.members[i].alive && !Reg.enemiesGroup.members[i].checkKilled() ) 
			{
				if (Reg.enemiesGroup.members[i].x <= (FlxG.camera.scroll.x + FlxG.camera.width + Reg.enemiesGroup.members[i].width))
					Reg.enemiesGroup.members[i].revive();
			}
		}
		if (boss.x <= (FlxG.camera.scroll.x + FlxG.camera.width + boss.width) && !boss.getVencido())
			boss.revive();
	}
	
	
	override public function create():Void
	{
		super.create();
		
		Reg.spawnDisparos();
		Reg.enemiesGroup = new FlxTypedGroup<BaseEnemies>();
		Reg.enemyDisparoGroup = new FlxTypedGroup<EnemyDisparo>();
		Reg.bossDisparoGroup = new FlxTypedGroup<Barriles>();
		Reg.powerUpGroup = new FlxTypedGroup<PowerUp>();
		
		
		
		
		
		Reg.score = 0;
		var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.oceantile__oel);
		tilemap = loader.loadTilemap(AssetPaths.Oceantileset__png, 16, 16, "tileset");
		tilemap2 = loader.loadTilemap(AssetPaths.fondo__png, 75, 240, "fondo");
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.NONE);
		tilemap.setTileProperties(2, FlxObject.ANY);
		for (i in 3...20) 
			tilemap.setTileProperties(i, FlxObject.ANY);			
		FlxG.worldBounds.set(0, 0, tilemap.width, tilemap.height);
		FlxG.camera.setScrollBounds(0, tilemap.width, 0, tilemap.height);
		loader.loadEntities(entityCreator, "entidades");	
		
		add(tilemap2);
		add(tilemap);
		player = new Player(10,100);
		add(player);
	
		Reg.powerUpGroup.add(new PowerUp(10,30));
		Reg.powerUpGroup.add(new PowerUp(50,30));
		Reg.powerUpGroup.add(new PowerUp(100,30));
		Reg.powerUpGroup.add(new PowerUp(150,30));
		Reg.powerUpGroup.add(new PowerUp(200, 60));
		Reg.powerUpGroup.add(new PowerUp(200, 80));
		Reg.powerUpGroup.add(new PowerUp(200, 100));
		Reg.powerUpGroup.add(new PowerUp(200,140));
		
		add(Reg.powerUpGroup);
		add(Reg.enemiesGroup);
		add(Reg.bossDisparoGroup);
		add(Reg.disparoGroup);
		add(boss);
		
		
		textoScore = new FlxText(10, 100);
		textoScore.text =Std.string(Reg.score);
		add(textoScore);
		
	}

	public function DisparoCollision():Void
	{
	
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
			//else if (Reg.enemiesGroup.members[l].alive)
				//{
					//if (FlxG.pixelPerfectOverlap(Reg.enemiesGroup.members[l], player))
						//player.perder();
				//}
		}
		
		if (FlxG.collide(tilemap, player))
			player.perder();
		//for (m in 0...Reg.bossDisparoGroup.length) 
		//{
			//if (FlxG.pixelPerfectOverlap(Reg.bossDisparoGroup.members[m], player))
			//{
				//player.perder(); 
				//trace("perdio");
			//}
		//}
		for (i in 0...Reg.disparoGroup.length)
			if (FlxG.collide(tilemap, Reg.disparoGroup.members[i]))
			{
				//disparoAux = Reg.disparoGroup.members[i];
				//Reg.disparoGroup.remove(Reg.disparoGroup.members[i]);
				//disparoAux.destroy();
				Reg.disparoGroup.members[i].kill();
			}
		for (i in 0...Reg.disparoGroup.length)
		{
			for (j in 0...Reg.enemyDisparoGroup.length)
			{
				if (FlxG.collide(Reg.disparoGroup.members[i], Reg.enemyDisparoGroup.members[j]))
				{	
					
					//disparoAux = Reg.disparoGroup.members[i];
					//Reg.disparoGroup.remove(Reg.disparoGroup.members[i]);
					//disparoAux.destroy();
					Reg.disparoGroup.members[i].kill();
					Reg.enemyDisparoGroup.members[j].destroy();
				}
			}
		}
		for (i in 0...Reg.enemyDisparoGroup.length)
		{
			if (FlxG.collide(tilemap, Reg.enemyDisparoGroup.members[i]))
				Reg.enemyDisparoGroup.members[i].destroy();
		}
		for (i in 0...Reg.disparoGroup.length) 
		{
			for (j in 0...Reg.enemiesGroup.length) 
			{
				if (FlxG.overlap(Reg.disparoGroup.members[i], Reg.enemiesGroup.members[j]))
				{
					//disparoAux = Reg.disparoGroup.members[i];
					//Reg.disparoGroup.remove                     (Reg.disparoGroup.members[i]);
					//disparoAux.destroy();
					Reg.disparoGroup.members[i].kill();
					Reg.enemiesGroup.members[j].leDispararon();
					Reg.enemiesGroup.members[j].kill();
					Reg.score += 30;
				}
			}
		}
		for (k in 0...Reg.disparoGroup.length) 
		{
			if (Reg.disparoGroup.members[k].x > FlxG.camera.scroll.x + FlxG.camera.width) 
			{
					//disparoAux = Reg.disparoGroup.members[k];
					//Reg.disparoGroup.remove(Reg.disparoGroup.members[k]);
					//disparoAux.destroy();
					Reg.disparoGroup.members[k].kill();
			}
		}
		//for (k in 0...Reg.powerUpGroup.length) 
		//{
			//if (FlxG.overlap(player,Reg.powerUpGroup.members[k])) 
			//{
				//Reg.powerUpGroup.members[k].destroy();
				//player.agarroPowerUp();
			//}
		//}
		hudUpdate();
		trace(Reg.disparoGroup.length);
		if (player.getVidas() == 0)
			{
				gameOver();
			}
	}
	private function gameOver():Void
	{
		tilemap.destroy();
		tilemap2.destroy();
		player.destroy();
		//fondo.destroy();
		boss.destroy();
		textoScore.destroy();
		
		Reg.disparoGroup.destroy();
		Reg.enemiesGroup.destroy();
		Reg.enemyDisparoGroup.destroy();
		Reg.bossDisparoGroup.destroy();
		Reg.powerUpGroup.destroy();
		
	
		
		FlxG.switchState(new MenuState());
	}
}
