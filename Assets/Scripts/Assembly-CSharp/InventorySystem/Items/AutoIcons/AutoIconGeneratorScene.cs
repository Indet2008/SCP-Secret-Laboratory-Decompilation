using UnityEngine;

namespace InventorySystem.Items.AutoIcons
{
	public abstract class AutoIconGeneratorScene : MonoBehaviour
	{
		[SerializeField]
		private Camera _camera;

		public void RenderIcon(RenderTexture texture, ItemBase item)
		{
			if (!texture.IsCreated())
			{
				texture.Create();
			}
			base.gameObject.SetActive(value: true);
			SetupScene(item);
			_camera.targetTexture = texture;
			_camera.Render();
			base.gameObject.SetActive(value: false);
		}

		protected abstract void SetupScene(ItemBase item);
	}
}
