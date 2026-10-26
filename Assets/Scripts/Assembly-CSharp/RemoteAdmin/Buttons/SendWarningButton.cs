using RemoteAdmin.Elements;
using UnityEngine;

namespace RemoteAdmin.Buttons
{
	public class SendWarningButton : SendButton
	{
		[SerializeField]
		private GameObject _warning;

		public override void Select()
		{
			int num = 0;
			foreach (PlayerRecord instance in PlayerRecord.Instances)
			{
				if (instance != null && instance.IsSelected)
				{
					num++;
				}
			}
			if (_warning != null && !_warning.activeSelf && num > 1 && num >= Mathf.Max(2, PlayerRecord.Instances.Count / 2))
			{
				_warning.SetActive(value: true);
				return;
			}
			if (_warning != null)
			{
				_warning.SetActive(value: false);
			}
			base.Select();
		}
	}
}