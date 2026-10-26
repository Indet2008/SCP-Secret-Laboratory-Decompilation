using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.PlayableScps.Scp1507
{
	public class Scp1507CorpseIndicator : MonoBehaviour
	{
		[SerializeField]
		private Image _imageFill;

		private float _fillAmount;

		public Scp1507Ragdoll Ragdoll;

		private const float FillSpeed = 0.5f;

		private void Update()
		{
			_fillAmount = Mathf.MoveTowards(_fillAmount, Ragdoll.RevivalProgress, Time.deltaTime * 0.5f);
			_imageFill.fillAmount = _fillAmount;
		}
	}
}
