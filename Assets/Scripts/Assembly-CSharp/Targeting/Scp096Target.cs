using UnityEngine;

namespace Targeting
{
	public class Scp096Target : TargetComponent
	{
		[SerializeField]
		private GameObject _targetParticles;

		private bool _isTarget;

		public override bool IsTarget
		{
			get
			{
				return _isTarget;
			}
			set
			{
				_targetParticles.SetActive(value);
				_isTarget = value;
			}
		}

		private void Start()
		{
			IsTarget = false;
		}
	}
}
