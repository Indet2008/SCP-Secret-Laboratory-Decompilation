using System;
using UnityEngine;

public class ReproProjectSettings : ScriptableObject
{
	[Serializable]
	public struct InputItem
	{
		public ReproProjectAssetType AssetType;

		public string AssetPath;
	}

	public string ProjectName;

	public string ProjectPath;

	public bool OpenProject;

	public int TextureScale;

	public InputItem[] InputFiles;

	public InputItem[] ProjectFiles;
}
