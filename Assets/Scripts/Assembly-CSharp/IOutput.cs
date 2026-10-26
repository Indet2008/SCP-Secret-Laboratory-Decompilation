using System;
using UnityEngine;

public interface IOutput
{
	string OutputId { get; }

	void Print(string text);

	void Print(string text, ConsoleColor c);

	void Print(string text, ConsoleColor c, Color rgbColor);

	bool Available();
}
