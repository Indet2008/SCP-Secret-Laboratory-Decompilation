using System.Collections.Generic;
using UnityEngine;

namespace InventorySystem.Items.AutoIcons
{
	public class AutoIconApplier : MonoBehaviour
	{
		private static readonly Stack<RenderTexture> RenderTexturePool = new Stack<RenderTexture>();

		private static readonly Dictionary<AutoIconGeneratorScene, AutoIconGeneratorScene> GeneratorInstances = new Dictionary<AutoIconGeneratorScene, AutoIconGeneratorScene>();

		// Not in the original: generator scenes are spawned far away from the facility so their camera never captures map geometry.
		private static readonly Vector3 GeneratorPosition = new Vector3(0f, 10000f, 0f);

		private RenderTexture _allocatedTexture;

		private bool _everRendered;

		private ItemBase _parentItem;

		[SerializeField]
		private AutoIconGeneratorScene _generator;

		private void OnDestroy()
		{
			if (!(_allocatedTexture == null))
			{
				RenderTexturePool.Push(_allocatedTexture);
			}
		}

		private void LateUpdate()
		{
			if (_everRendered && !_allocatedTexture.IsCreated())
			{
				ReRenderIcon();
			}
		}

		private static RenderTexture GetFreeTexture()
		{
			if (RenderTexturePool.TryPop(out var result))
			{
				return result;
			}
			return new RenderTexture(512, 512, 24, RenderTextureFormat.Default, RenderTextureReadWrite.Linear);
		}

		private static AutoIconGeneratorScene GetGeneratorScene(AutoIconGeneratorScene template)
		{
			if (GeneratorInstances.TryGetValue(template, out var value) && value != null)
			{
				return value;
			}
			value = Object.Instantiate(template, GeneratorPosition, Quaternion.identity);
			if (Application.isPlaying)
			{
				Object.DontDestroyOnLoad(value);
			}
			value.gameObject.SetActive(value: false);
			GeneratorInstances[template] = value;
			return value;
		}

		private void ReRenderIcon()
		{
			if (_allocatedTexture == null)
			{
				_allocatedTexture = GetFreeTexture();
				_parentItem = GetComponent<ItemBase>();
			}
			GetGeneratorScene(_generator).RenderIcon(_allocatedTexture, _parentItem);
			_parentItem.Icon = _allocatedTexture;
			_everRendered = true;
		}

		public void UpdateIcon()
		{
			ReRenderIcon();
		}
	}
}
