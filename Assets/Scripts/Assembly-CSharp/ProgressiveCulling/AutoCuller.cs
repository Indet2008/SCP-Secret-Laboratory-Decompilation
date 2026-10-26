using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ProgressiveCulling
{
	[Serializable]
	public class AutoCuller
	{
		[SerializeField]
		private List<GameObject> _cullableGameObjects = new List<GameObject>();

		[SerializeField]
		private List<Renderer> _cullableRenderers = new List<Renderer>();

		[SerializeField]
		private List<Behaviour> _cullableBehaviors = new List<Behaviour>();

		public const string DoNotCullTag = "DoNotCull";

		public void Generate(GameObject root, Predicate<GameObject> cullFilter = null, Predicate<GameObject> deactivationRule = null, bool ignoreDoNotCullTag = false)
		{
			_cullableGameObjects.Clear();
			_cullableRenderers.Clear();
			_cullableBehaviors.Clear();
			ProcessGameObject(root, cullFilter, deactivationRule, !ignoreDoNotCullTag);
		}

		public void SetVisibility(bool isVisible)
		{
			for (int num = _cullableGameObjects.Count - 1; num >= 0; num--)
			{
				GameObject gameObject = _cullableGameObjects[num];
				if (gameObject == null)
				{
					_cullableGameObjects.RemoveAt(num);
				}
				else
				{
					gameObject.SetActive(isVisible);
				}
			}
			for (int num2 = _cullableBehaviors.Count - 1; num2 >= 0; num2--)
			{
				Behaviour behaviour = _cullableBehaviors[num2];
				if (behaviour == null)
				{
					_cullableBehaviors.RemoveAt(num2);
				}
				else
				{
					behaviour.enabled = isVisible;
				}
			}
			for (int num3 = _cullableRenderers.Count - 1; num3 >= 0; num3--)
			{
				Renderer renderer = _cullableRenderers[num3];
				if (renderer == null)
				{
					_cullableRenderers.RemoveAt(num3);
				}
				else
				{
					renderer.enabled = isVisible;
				}
			}
		}

		private void ProcessGameObject(GameObject root, Predicate<GameObject> cullFilter, Predicate<GameObject> deactivationFilter, bool checkTag)
		{
			if ((cullFilter != null && !cullFilter(root)) || (checkTag && root.CompareTag("DoNotCull")) || (root.TryGetComponent<IAutoCullerOverrideComponent>(out var component) && !component.AllowAutoCulling))
			{
				return;
			}
			if (deactivationFilter != null && deactivationFilter(root))
			{
				_cullableGameObjects.Add(root);
				return;
			}
			Transform transform = root.transform;
			int childCount = transform.childCount;
			for (int i = 0; i < childCount; i++)
			{
				GameObject gameObject = transform.GetChild(i).gameObject;
				ProcessGameObject(gameObject, cullFilter, deactivationFilter, checkTag);
			}
			Component[] components = root.GetComponents<Component>();
			foreach (Component component2 in components)
			{
				if (component2 is Renderer item)
				{
					_cullableRenderers.Add(item);
				}
				if (component2 is Behaviour item2 && (component2 is Light || component2 is Canvas || component2 is CanvasScaler || component2 is UIBehaviour || component2 is ReflectionProbe))
				{
					_cullableBehaviors.Add(item2);
				}
			}
		}
	}
}
