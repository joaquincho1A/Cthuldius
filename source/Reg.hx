package;

import flixel.group.FlxGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;
import flixel.FlxG;
import sprites.BaseEnemies;
import sprites.Player;
import sprites.Disparo;
import sprites.EnemyDisparo;


class Reg
{
	static public var disparoGroup:FlxTypedGroup<Disparo> = new FlxTypedGroup<Disparo>();
	
	static public var enemiesGroup:FlxTypedGroup<BaseEnemies> = new FlxTypedGroup<BaseEnemies>();
	
	static public var enemyDisparoGroup:FlxTypedGroup<EnemyDisparo> = new FlxTypedGroup<EnemyDisparo>();
	
	static public var posXplayer:Float;
	static public var posYplayer:Float;
}