using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Items.Firearms.Attachments
{
	public class SpectatorSelectorFirearmButton : Button
	{
		private SpectatorAttachmentSelector _selector;

		private Firearm _fa;

		private RawImage _img;

		private Color _normalColor;

		private const float NormalColor = 0.75f;

		public void Setup(SpectatorAttachmentSelector selector, Firearm fa)
		{
			_img = GetComponent<RawImage>();
			_selector = selector;
			_img.texture = fa.Icon;
			_normalColor = Color.Lerp(Color.clear, Color.white, 0.75f);
			_fa = fa;
		}

		private void Update()
		{
			_img.color = Color.Lerp(_img.color, (_selector.SelectedFirearm == _fa) ? Color.white : _normalColor, Time.deltaTime * 10f);
		}

		public void Click()
		{
			_selector.SelectFirearm(_fa);
		}
	}
}
