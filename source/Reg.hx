package;

import flixel.group.FlxGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;
import flixel.FlxG;
import sprites.BaseEnemies;
import sprites.Player;
import sprites.Disparo;
import sprites.EnemyDisparo;
import sprites.PowerUp;
import sprites.Barriles;


class Reg
{
	static public var posXplayer:Float;
	static public var posYplayer:Float;
	static public var widthPlayer:Float;
	static public var heightPlayer:Float;
	static public var vidas:Int = 3;
	static public var disparoGroup:FlxTypedGroup<Disparo> = new FlxTypedGroup<Disparo>();
	static public var enemiesGroup:FlxTypedGroup<BaseEnemies> = new FlxTypedGroup<BaseEnemies>();
	static public var enemyDisparoGroup:FlxTypedGroup<EnemyDisparo> = new FlxTypedGroup<EnemyDisparo>();
	static public var bossDisparoGroup:FlxTypedGroup<Barriles> = new FlxTypedGroup<Barriles>();
	static public var powerUpGroup:FlxTypedGroup<PowerUp> = new FlxTypedGroup<PowerUp>();
	
}