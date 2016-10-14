package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Boss extends FlxSprite
{
	private var vida:Int;
	private var movimiento:Bool;
	private var countMove:Int;
	private var disparo:Int;
	private var delayDisparo:Int;
	private var vencido:Bool;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Ballena__png, false, 128, 128);
		vida = 30;
		movimiento = true;
		countMove = 0;
		delayDisparo = 0;
		vencido = false;
		kill();
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		delayDisparo++;
		move();
		if (delayDisparo == 30)
			ataque();
	}
	private function move():Void
	{
		countMove++;
		if (movimiento)
			velocity.y = -30;
		else	
			velocity.y = 30;
		if (countMove == 120)
		{
			countMove = 0;
			movimiento = !movimiento;
		}
	}
	private function ataque():Void
	{
		delayDisparo = 0;
		disparo = FlxG.random.int(1, 6);
		switch(disparo)
		{
			case 1:
				Reg.bossDisparoGroup.add(new Barriles(x, 40));
			case 2:
				Reg.bossDisparoGroup.add(new Barriles(x, 70));
			case 3:
				Reg.bossDisparoGroup.add(new Barriles(x, 110));
			case 4:
				Reg.bossDisparoGroup.add(new Barriles(x, 150));
			case 5:
				Reg.bossDisparoGroup.add(new Barriles(x, 190));
				
		}
		for (i in 0...Reg.disparoGroup.length) 
		{
			if (FlxG.overlap(this, Reg.disparoGroup.members[i]))
			{
				Reg.disparoGroup.members[i].destroy();
				vida--;
			}
		}
		if (vida <= 0)	
		{	
			vencido = true;
			kill();
			Reg.score += 1000;
		}
	}
	public function getVencido():Bool
	{
		return vencido;
	}
}