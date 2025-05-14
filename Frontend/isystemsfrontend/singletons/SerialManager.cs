using Godot;
using System;
//using System.IO.Ports; // for .NET SerialPort

public partial class SerialManager : Node
{
	//private SerialPort _port;
	
	public override void _Ready()
	{
		GD.Print("Hello from C# to Godot :)");
		//_port = new SerialPort(portName, (Int32)baudRate, Parity.None, 8, StopBits.One);
	}
	
	public override void _Process(double delta)
	{
		// Called every frame. Delta is time since the last frame.
		// Update game logic here.
	}
}
