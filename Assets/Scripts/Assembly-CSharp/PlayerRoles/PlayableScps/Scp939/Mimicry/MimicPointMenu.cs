using TMPro;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class MimicPointMenu : MimicryMenuBase
	{
		[SerializeField]
		private GameObject _onRoot;

		[SerializeField]
		private GameObject _offRoot;

		[SerializeField]
		private TMP_Text _distanceText;

		private MimicPointController _mimicController;

		private const string DistanceTextFormat = "{0}m / {1}m";

		private void Update()
		{
			bool active = _mimicController.Active;
			_onRoot.SetActive(!active);
			_offRoot.SetActive(active);
			if (active)
			{
				int a = Mathf.RoundToInt(_mimicController.Distance);
				int num = Mathf.RoundToInt(_mimicController.MaxDistance);
				_distanceText.text = $"{Mathf.Min(a, num)}m / {num}m";
			}
		}

		protected override void Setup(Scp939Role role)
		{
			base.Setup(role);
			role.SubroutineModule.TryGetSubroutine<MimicPointController>(out _mimicController);
		}

		public void RequestToggle()
		{
			_mimicController.ClientToggle();
			if (MimicryMenuController.SingletonSet)
			{
				MimicryMenuController.Singleton.IsEnabled = false;
			}
		}
	}
}
