using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Map
{
	public class Scp079DetectedPlayerIndicator : MonoBehaviour
	{
		private ReferenceHub _trackedPlayer;

		private Transform _rotTr;

		private PlayerRoleBase _role;

		private RectTransform _rt;

		private IZoneMap[] _maps;

		private float _mainTimer;

		[SerializeField]
		private CanvasGroup _mainRoot;

		[SerializeField]
		private CanvasGroup _lostRoot;

		[SerializeField]
		private UiCircle _rippleCircle;

		[SerializeField]
		private AnimationCurve _mainFadeAnim;

		[SerializeField]
		private AnimationCurve _lostFadeAnim;

		[SerializeField]
		private AnimationCurve _rippleRadius;

		[SerializeField]
		private AnimationCurve _rippleWidth;

		[SerializeField]
		private int _mainRepeats;

		[SerializeField]
		private float _deleteTime;

		public void Setup(ReferenceHub ply, IZoneMap[] maps, RectTransform rotationTransform)
		{
			_trackedPlayer = ply;
			_rotTr = rotationTransform;
			_role = ply.roleManager.CurrentRole;
			_rt = GetComponent<RectTransform>();
			_maps = maps;
		}

		private void Update()
		{
			if (!UpdateMain())
			{
				UpdateLost();
			}
		}

		private bool UpdateMain()
		{
			if (_mainTimer >= (float)_mainRepeats)
			{
				return false;
			}
			_mainTimer = Mathf.Min(_mainTimer + Time.deltaTime, _mainRepeats);
			if (_trackedPlayer == null || _role != _trackedPlayer.roleManager.CurrentRole)
			{
				return false;
			}
			float time = _mainTimer - (float)(int)_mainTimer;
			_mainRoot.alpha = _mainFadeAnim.Evaluate(time);
			_rippleCircle.Width = _rippleWidth.Evaluate(time);
			_rippleCircle.Radius = _rippleRadius.Evaluate(time);
			_maps.ForEach((IZoneMap x) =>
			{
				x.TrySetPlayerIndicator(_trackedPlayer, _rt, exact: true);
			});
			_rt.rotation = _rotTr.rotation;
			return true;
		}

		private void UpdateLost()
		{
			_mainRoot.alpha = 0f;
			_lostRoot.alpha = _lostFadeAnim.Evaluate(_deleteTime);
			_deleteTime -= Time.deltaTime;
			if (!(_deleteTime > 0f))
			{
				Object.Destroy(base.gameObject);
			}
		}
	}
}
