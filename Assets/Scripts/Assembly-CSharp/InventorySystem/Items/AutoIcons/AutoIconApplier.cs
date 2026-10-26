using System.Collections.Generic;
using UnityEngine;

namespace InventorySystem.Items.AutoIcons
{
	// Client-only behaviour stripped from the server build: renders the item's icon at runtime
	// through its generator scene (used by keycards, whose look depends on their details).
	public class AutoIconApplier : MonoBehaviour
	{
		private const int IconResolution = 256;

		// Far away from the facility so the generator camera never captures map geometry.
		private static readonly Vector3 GeneratorPosition = new Vector3(0f, 10000f, 0f);

		private static readonly Dictionary<AutoIconGeneratorScene, AutoIconGeneratorScene> GeneratorInstances = new Dictionary<AutoIconGeneratorScene, AutoIconGeneratorScene>();

		[SerializeField]
		private AutoIconGeneratorScene _generator;

		private RenderTexture _texture;

		public void UpdateIcon()
		{
			if (_generator == null || !TryGetComponent<ItemBase>(out var component) || !TryGetGenerator(out var generator))
			{
				return;
			}
			if (_texture == null)
			{
				_texture = new RenderTexture(IconResolution, IconResolution, 24, RenderTextureFormat.ARGB32)
				{
					name = base.name + " Icon",
					antiAliasing = 4
				};
			}
			try
			{
				generator.RenderIcon(_texture, component);
				component.Icon = _texture;
			}
			catch (System.Exception exception)
			{
				Debug.LogException(exception, this);
			}
		}

		private bool TryGetGenerator(out AutoIconGeneratorScene generator)
		{
			if (GeneratorInstances.TryGetValue(_generator, out generator) && generator != null)
			{
				return true;
			}
			bool flag = _generator.gameObject.scene.IsValid();
			generator = (flag ? _generator : Object.Instantiate(_generator, GeneratorPosition, Quaternion.identity));
			if (!flag)
			{
				Object.DontDestroyOnLoad(generator.gameObject);
				generator.gameObject.SetActive(value: false);
			}
			GeneratorInstances[_generator] = generator;
			return true;
		}
	}
}
