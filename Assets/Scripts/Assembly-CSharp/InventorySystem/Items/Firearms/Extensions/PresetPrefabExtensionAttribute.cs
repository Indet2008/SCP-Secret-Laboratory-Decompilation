using System;

namespace InventorySystem.Items.Firearms.Extensions
{
	[AttributeUsage(AttributeTargets.Class, AllowMultiple = true)]
	public class PresetPrefabExtensionAttribute : Attribute
	{
		public readonly string PrefabName;

		public readonly Type ExtensionType;

		public PresetPrefabExtensionAttribute(string prefabName, Type extensionType)
		{
			PrefabName = prefabName;
			ExtensionType = extensionType;
		}

		public PresetPrefabExtensionAttribute(string prefabName, bool isWorldmodel)
		{
			PrefabName = prefabName;
			ExtensionType = (isWorldmodel ? typeof(IWorldmodelExtension) : typeof(IViewmodelExtension));
		}
	}
}
