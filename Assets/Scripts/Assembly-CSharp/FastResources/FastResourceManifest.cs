using System.Collections.Generic;
using UnityEngine;

namespace FastResources
{
	[CreateAssetMenu(fileName = "Fast Resource Manifest", menuName = "ScriptableObject/Fast Resource Manifest")]
	public class FastResourceManifest : ScriptableObject
	{
		[HideInInspector]
		public string TypeName;

		[HideInInspector]
		public bool SearchInChildren;

		[HideInInspector]
		public bool FetchAllComponentsPerObject;

		[HideInInspector]
		public bool IncludeSubfolders;

		public List<Object> SpecificObjects;
	}
}
