package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flash.system.System; 

class MenuState extends FlxState
{
	private var textTitulo:FlxText;
	private var textJugar:FlxText;
	private var textIntegrantes:FlxText;
	private var textHighScore:FlxText;
	private var textInstr:FlxText;
	private var textSalir:FlxText;
	
	private var flecha:FlxSprite;
	private var opcion:Int;
	override public function create():Void
	{
		super.create();
		textTitulo = new FlxText(50, 30);
		textTitulo.text = "NOSEQUEPONER";
		textTitulo.scale.x = 2;
		textTitulo.scale.y = 2;
		
		textJugar = new FlxText(110, 100);
		textJugar.text = "Jugar";
		textJugar.scale.x = 1.5;
		textJugar.scale.y = 1.5;
		
		textIntegrantes = new FlxText(10, FlxG.height - 20);
		textIntegrantes.text = "Micaela Pereyra, Joaquin Liberatore, R.I.P Agus";
		
		textHighScore = new FlxText(95,FlxG.height - 40);
		textHighScore.text = "Highscore: " + Reg.highScore;
		
		textInstr = new FlxText(95, 120);
		textInstr.text = "Instrucciones";
		textInstr.scale.x = 1.5;
		textInstr.scale.y = 1.5;
		
		textSalir = new FlxText(110, 140);
		textSalir.text = "Salir";
		textSalir.scale.x = 1.5;
		textSalir.scale.y = 1.5;
		
		flecha = new FlxSprite(60, 85);
		flecha.loadGraphic(AssetPaths.NewPiskel__png);
		
		opcion = 1;
		
		add(flecha);
		add(textTitulo);
		add(textIntegrantes);
		add(textJugar);
		add(textHighScore);
		add(textInstr);
		add(textSalir);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		moverFlechita();
		if (FlxG.keys.pressed.SPACE)
		{ 
			switch (opcion)
			{
				case 1:
					FlxG.switchState(new PlayState());
				case 2:
					
				case 3:
					System.exit(0);
			}
			
		}
	}
	private function moverFlechita():Void
	{
		if (FlxG.keys.justPressed.UP)
		{
			if (opcion > 1)
				opcion--;
		}
		else if (FlxG.keys.justPressed.DOWN)
		{
			if (opcion < 3)
				opcion++;
		}	
		switch(opcion)
		{
			case 1:
				{
					flecha.x = 65;
					flecha.y = 85;
				}
			case 2:
				{
					flecha.x = 40;
					flecha.y = 105;
				}
			case 3:
				{
					flecha.x = 65;
					flecha.y = 125;
				}
		}
	}
}
