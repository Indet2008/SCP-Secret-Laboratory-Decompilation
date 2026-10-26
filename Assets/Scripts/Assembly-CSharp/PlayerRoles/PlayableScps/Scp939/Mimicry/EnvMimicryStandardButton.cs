using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	[RequireComponent(typeof(Button))]
	public class EnvMimicryStandardButton : MonoBehaviour
	{
		[SerializeField]
		private EnvMimicrySequence[] _randomSequences;

		private bool _prevState;

		private Button _button;

		private GameObject _buttonGameObject;

		private bool _cacheSet;

		private EnvironmentalMimicry _cachedSubroutine;

		protected virtual bool IsAvailable => true;

		protected virtual void Awake()
		{
			_button = GetComponent<Button>();
			_button.onClick.AddListener(OnButtonPressed);
			_buttonGameObject = _button.gameObject;
			_prevState = !IsAvailable;
			StaticUnityMethods.OnUpdate += AlwaysUpdate;
		}

		protected virtual void OnDestroy()
		{
			StaticUnityMethods.OnUpdate -= AlwaysUpdate;
		}

		protected virtual void AlwaysUpdate()
		{
			if (_prevState != IsAvailable)
			{
				bool flag = !_prevState;
				_buttonGameObject.SetActive(flag);
				_prevState = flag;
			}
		}

		protected virtual void OnButtonPressed()
		{
			if (TryGetLocalSubroutine(out var localSubroutine))
			{
				localSubroutine.ClientSelect(_randomSequences.RandomItem());
			}
		}

		private bool TryGetLocalSubroutine(out EnvironmentalMimicry localSubroutine)
		{
			localSubroutine = _cachedSubroutine;
			if (_cacheSet)
			{
				return _cachedSubroutine != null;
			}
			if (!ReferenceHub.TryGetLocalHub(out var hub))
			{
				return false;
			}
			if (!(hub.roleManager.CurrentRole is Scp939Role scp939Role))
			{
				return false;
			}
			if (!scp939Role.SubroutineModule.TryGetSubroutine<EnvironmentalMimicry>(out localSubroutine))
			{
				return false;
			}
			_cacheSet = true;
			_cachedSubroutine = localSubroutine;
			return true;
		}
	}
}
