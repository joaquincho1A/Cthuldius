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
	private var vidas:Int = 3;
	private var puedeDisparar:Bool;
	private var counterDisparos:Int;
	private var powerUpAcumulado:Int;
	private var speed:Int = 100;
	private var shield:Escudo ;
	private var vidasShield:Int = 2;
	private var perdio:Bool;
	
	private var misil:Bool;
	private var recoil:Int;
	
	private var invulnerable:Bool = false;
	private var invulCounter:Int = 0;
	private var invulEfectCounter:Int = 0;
	public function getVidas():Int
	{
		return vidas;
	}
	public function getShield():Escudo
	{
		return shield; 
	}
	public function daniarShield():Void
	{
		vidasShield--;
	}
	public function agarroPowerUp():Void
	{
		powerUpAcumulado++;
	}
	public function perder():Void
	{
		perdio = true;
	}
	public function checkPerdio():Bool
	{
		return perdio;
	}
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.sub__png);
		
		
		perdio = false;
		puedeDisparar = true;
		counterDisparos = 0;
		misil = false;
		recoil = 30;
		
		powerUpAcumulado = 0;

		Reg.widthPlayer = width;
		Reg.heightPlayer = height;
		
		shield = new Escudo(x + width + 3, y);
		FlxG.state.add(shield);
		shield.kill();
	}
	override public function update(elapsed:Float):Void
	{
		//x += 1;
		Reg.posXplayer = x+width/2;
		Reg.posYplayer = y+height/2;
		super.update(elapsed);
		if (FlxG.keys.pressed.LEFT)
			x -= speed * FlxG.elapsed;
		else if (FlxG.keys.pressed.RIGHT)
			x += speed * FlxG.elapsed;
		if (FlxG.keys.pressed.UP)
			y -= speed * FlxG.elapsed;
		else if (FlxG.keys.pressed.DOWN)
			y += speed * FlxG.elapsed;
		if (y > (FlxG.height - this.height))
			y = (FlxG.height - this.height)
		else if (y < 0)
			y = 0;	
		if (x > (FlxG.camera.scroll.x + FlxG.camera.width - this.width))
			x = FlxG.camera.scroll.x + FlxG.camera.width - this.width;
		else if (x < FlxG.camera.scroll.x)
			x = FlxG.camera.scroll.x;
				
		if (!invulnerable) 
		{
			if (FlxG.keys.pressed.SPACE && puedeDisparar)
			{ 
				Reg.disparoGroup.add(new Disparo(1,this.x + width, this.y + height/2));
				if(misil)	
					Reg.disparoGroup.add(new Disparo(2,this.x + width/2, this.y + height/2));				
				puedeDisparar = false;
				counterDisparos = 0;						
			}
			if (FlxG.keys.justPressed.SHIFT)
			{ 
				switch(powerUpAcumulado)
				{
					case 1:
						{
							speed += 50;
							powerUpAcumulado = 0;
						}
					case 2:
						{
							powerUpAcumulado = 0;
							misil = true;
						}
					case 3:
						{
							shield.revive();
							powerUpAcumulado = 0;
						}
					case 4:
						{
							powerUpAcumulado = 0;
							recoil = 15;
						}
				}
			}
			
	
			
			
			
			
			
			
			if (!puedeDisparar)
				counterDisparos++;
			if (counterDisparos == recoil)
				puedeDisparar = true;
					
				checkCollisions();	
		}	
		else 
		{
			invulCounter++;
			invulEfectCounter++;
			if (invulEfectCounter == 10) 
			{
				visible = !visible;
				invulEfectCounter = 0;
			}
			if (invulCounter == 160) 
			{
				visible = true;
				invulEfectCounter = 0;
				invulCounter = 0;
				invulnerable = false;
			}
		}
		if (vidasShield <= 0)
			shield.kill();
	}
	
	private function checkCollisions():Void
	{
		for (i in 0...Reg.enemiesGroup.length) 
		{
		
			if (Reg.enemiesGroup.members[i].alive)
			{
				if (FlxG.pixelPerfectOverlap(Reg.enemiesGroup.members[i], this))
				{
					invulnerable = true;
					vidas--;
				}
			}
		}	
		for (j in 0...Reg.bossDisparoGroup.length) 
		{
			if (FlxG.pixelPerfectOverlap(Reg.bossDisparoGroup.members[j], this) && !Reg.bossDisparoGroup.members[j].getDestruido())
			{
				invulnerable = true;
				vidas--;
			}
		}			
		for (k in 0...Reg.powerUpGroup.length) 
		{
			if (FlxG.overlap(this,Reg.powerUpGroup.members[k])) 
			{
				Reg.powerUpGroup.members[k].destroy();
				agarroPowerUp();
			}
		}		
	}
}