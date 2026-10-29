using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace WaterPhysics
{
	// Restores the downward flow of the HCZ waterfall: the original shader graph scrolled its UVs,
	// the materials now use HDRP/Lit, so the scroll is driven from here.
	public class WaterfallScroller : MonoBehaviour
	{
		private const string MaterialPrefix = "Waterfall Material";

		private const string StProperty = "_BaseColorMap_ST";

		private const float FlowSpeed = 0.35f;

		private readonly List<Material> _materials = new List<Material>();

		private readonly List<Vector4> _originalSt = new List<Vector4>();

		[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
		private static void Init()
		{
			GameObject go = new GameObject("WaterfallScroller");
			go.hideFlags = HideFlags.HideAndDontSave;
			DontDestroyOnLoad(go);
			go.AddComponent<WaterfallScroller>();
		}

		private void Awake()
		{
			SceneManager.sceneLoaded += OnSceneLoaded;
			Collect();
		}

		private void OnSceneLoaded(Scene scene, LoadSceneMode mode)
		{
			Collect();
		}

		private void Collect()
		{
			foreach (Material material in Resources.FindObjectsOfTypeAll<Material>())
			{
				if (material.name.StartsWith(MaterialPrefix) && material.HasProperty(StProperty) && !_materials.Contains(material))
				{
					_materials.Add(material);
					_originalSt.Add(material.GetVector(StProperty));
				}
			}
		}

		private void Update()
		{
			float offset = Time.time * FlowSpeed % 1f;
			for (int i = 0; i < _materials.Count; i++)
			{
				if (_materials[i] == null)
				{
					continue;
				}
				Vector4 st = _originalSt[i];
				st.w += offset;
				_materials[i].SetVector(StProperty, st);
			}
		}

		private void OnDestroy()
		{
			SceneManager.sceneLoaded -= OnSceneLoaded;
			for (int i = 0; i < _materials.Count; i++)
			{
				if (_materials[i] != null)
				{
					_materials[i].SetVector(StProperty, _originalSt[i]);
				}
			}
		}
	}
}
