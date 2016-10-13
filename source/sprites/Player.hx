package sprites;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Player extends FlxSprite
{
	private var puedeDisparar:Bool;
	private var counterDisparos:Int;
	private var powerUpAcumulado:Int;
	private var powerUpActual:Int;
	private var speed:Int = 100;
	private var shield:Escudo ;
	private var vidasShield:Int = 2;
	private var perdio:Bool;
	
	public function getShield():Escudo
	{
		return shield; 
	}
	public function daniarShield():Void
	{
		vidasShield--;
		trace("perdio vida");
	}
	public function agarroPowerUp():Void
	{
		powerUpAcumulado++;
	}
	public function perder():Void
	{
		perdio = true;
		Reg.vidas = 3;
	}
	public function checkPerdio():Bool
	{
		return perdio;
	}
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		//loadGraphic(AssetPaths.NewPiskel__png);
		makeGraphic(10, 10);
		
		perdio = false;
		puedeDisparar = true;
		counterDisparos = 0;
		
		powerUpAcumulado = 0;
		powerUpActual = 0;
		
		Reg.widthPlayer = width;
		Reg.heightPlayer = height;
		
		shield = new Escudo(x + width + 3, y);
		FlxG.state.add(shield);
		shield.kill();
	}
	override public function update(elapsed:Float):Void
	{
		x += 1;
		Reg.posXplayer = x+width/2;
		Reg.posYplayer = y+height/2;
		super.update(elapsed);
		if (FlxG.keys.pressed.LEFT)
			x -= speed * FlxG.elapsed;
		if (FlxG.keys.pressed.RIGHT)
			x += speed * FlxG.elapsed;
		if (FlxG.keys.pressed.UP)
			y -= speed * FlxG.elapsed;
		if (FlxG.keys.pressed.DOWN)
			y += speed * FlxG.elapsed;
		if (FlxG.keys.pressed.SPACE && puedeDisparar)
		{ 
			switch(powerUpActual)
			{
				case 0,1:
					{
						Reg.disparoGroup.add(new Disparo(1,this.x + width, this.y + height/2));
						FlxG.state.add(Reg.disparoGroup);
						puedeDisparar = false;
						counterDisparos = 0;
					}
				default:
					{
						Reg.disparoGroup.add(new Disparo(1,this.x + width, this.y + height/2));
						FlxG.state.add(Reg.disparoGroup);
						Reg.disparoGroup.add(new Disparo(2,this.x + width/2, this.y + height/2));
						FlxG.state.add(Reg.disparoGroup);
						puedeDisparar = false;
						counterDisparos = 0;
					}
			}
		}
		if (FlxG.keys.justPressed.SHIFT)
		{ 
			switch(powerUpAcumulado)
			{
				case 1:
					{
						speed += 50;
						powerUpActual = 1;
						powerUpAcumulado = 0;
					}
				case 2:
					{
						powerUpActual = 2;
						powerUpAcumulado = 0;
					}
				case 3:
					{
						shield.revive();
						powerUpAcumulado = 0;
					}
				default:
					{

					}
			}
		}
		if (!puedeDisparar)
			counterDisparos++;
		if (counterDisparos == 30)
			puedeDisparar = true;
		if (y > (FlxG.height - this.height))
			y = (FlxG.height - this.height)
		else if (y < 0)
			y = 0;
			
		if (x > (FlxG.camera.scroll.x + FlxG.camera.width - this.width))
			x = FlxG.camera.scroll.x + FlxG.camera.width - this.width;
		else if (x < FlxG.camera.scroll.x)
			x = FlxG.camera.scroll.x;
			
			
		if (vidasShield <= 0)
		{	trace("murio shield");
			shield.kill();
		}
	}
}