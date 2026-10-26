using UnityEngine;

namespace Interactables.Interobjects.DoorButtons
{
	public class KeycardScannerNfcIcon : MonoBehaviour
	{
		[SerializeField]
		private Material _deniedMat;

		[SerializeField]
		private Material _errorMat;

		[SerializeField]
		private Material _grantedMat;

		[SerializeField]
		private Material _regularMat;

		[SerializeField]
		private MeshRenderer _renderer;

		private float _remainingUntilRegular;

		private void Awake()
		{
			base.enabled = false;
		}

		private void Update()
		{
			_remainingUntilRegular -= Time.deltaTime;
			if (!(_remainingUntilRegular > 0f))
			{
				SetRegular();
			}
		}

		public void SetMaterial(Material mat, float? time)
		{
			_renderer.sharedMaterial = mat;
			if (time.HasValue)
			{
				base.enabled = true;
				_remainingUntilRegular = time.Value;
			}
			else
			{
				base.enabled = false;
			}
		}

		public void SetRegular()
		{
			SetMaterial(_regularMat, null);
		}

		public void SetGranted()
		{
			SetMaterial(_grantedMat, null);
		}

		public void SetTemporaryGranted(float timeSeconds)
		{
			SetMaterial(_grantedMat, timeSeconds);
		}

		public void SetDenied()
		{
			SetMaterial(_deniedMat, null);
		}

		public void SetTemporaryDenied(float timeSeconds)
		{
			SetMaterial(_deniedMat, timeSeconds);
		}

		public void SetError()
		{
			SetMaterial(_errorMat, null);
		}
	}
}
