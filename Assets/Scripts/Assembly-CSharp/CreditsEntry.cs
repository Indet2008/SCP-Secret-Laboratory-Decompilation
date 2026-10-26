using System.Linq;
using UnityEngine;

public class CreditsEntry
{
	public string Title;

	public string Name;

	public bool Multi;

	public Color Color;

	public CreditsEntry()
	{
	}

	public CreditsEntry(string title, string name)
	{
		Multi = false;
		Title = title;
		Name = name;
		Color = Color.white;
	}

	public CreditsEntry(string title, string name, Color color)
	{
		Multi = false;
		Title = title;
		Name = name;
		Color = color;
	}

	public CreditsEntry(string name)
	{
		Multi = false;
		Title = "";
		Name = name;
	}

	public CreditsEntry(string[] names)
	{
		Multi = true;
		Title = "";
		Name = names.Aggregate("", (string current, string n) => current + n + "\n");
	}
}
