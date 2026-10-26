using PlayerRoles;
using UnityEngine;

// Client-only (body stripped from the server build). Ported from the SL 12 CE client onto the v14 layout:
// the black "you are <role>" intro that fades out after spawning.
public class StartScreen : MonoBehaviour
{
	[global::System.Serializable]
	private struct FadeElement
	{
		public global::UnityEngine.AnimationCurve FadeCurve;

		public global::UnityEngine.CanvasRenderer Renderer;
	}

	private static StartScreen _singleton;

	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	[global::UnityEngine.SerializeField]
	private int _helpScreenIndex;

	[global::UnityEngine.SerializeField]
	private StartScreen.FadeElement[] _fadeElements;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.AnimationCurve _fadeLimitNormal;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.AnimationCurve _fadeLimitFast;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.AnimationCurve _scaleAnim;

	[global::UnityEngine.SerializeField]
	private global::MapGeneration.Holidays.HolidayAudioClip _humanBellSfx;

	[global::UnityEngine.SerializeField]
	private global::MapGeneration.Holidays.HolidayAudioClip _scpBellSfx;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.UI.Text _roleNameText;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.UI.Text _roleDescText;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.Transform _scaler;

	private float _elapsed;

	private float _length;

	private bool _hasHelpMenu;

	private AnimationCurve _limiter;

	private AudioSource _audioSource;

	public static void Show(PlayerRoleBase prb)
	{
		if (_singleton != null)
		{
			_singleton.Play(prb);
		}
	}

	private void Awake()
	{
		_singleton = this;
		_audioSource = gameObject.AddComponent<AudioSource>();
		_audioSource.playOnAwake = false;
		_audioSource.spatialBlend = 0f;
		gameObject.SetActive(false);
	}

	private void OnDestroy()
	{
		if (_singleton == this)
		{
			_singleton = null;
		}
	}

	private void Play(PlayerRoleBase prb)
	{
		_limiter = _fadeLimitNormal;
		_length = (_limiter != null && _limiter.length > 0) ? _limiter.keys[_limiter.length - 1].time : 3f;
		if (_roleNameText != null)
		{
			_roleNameText.text = prb.RoleName;
			_roleNameText.color = prb.RoleColor;
		}
		if (_roleDescText != null)
		{
			_roleDescText.text = TranslationReader.Get("Class_Descriptions", (int)prb.RoleTypeId, string.Empty);
		}
		_hasHelpMenu = prb.RoleHelpInfo != null;
		gameObject.SetActive(true);
		global::MapGeneration.Holidays.HolidayAudioClip bell = (prb.Team == Team.SCPs) ? _scpBellSfx : _humanBellSfx;
		AudioClip clip = (bell != null) ? bell.GetClip() : null;
		if (clip != null)
		{
			_audioSource.PlayOneShot(clip);
		}
		_elapsed = 0f;
		Update();
	}

	private void Update()
	{
		if (_limiter == null)
		{
			gameObject.SetActive(false);
			return;
		}
		if (_scaler != null && _scaleAnim != null)
		{
			float scale = _scaleAnim.Evaluate(_elapsed);
			_scaler.localScale = new Vector3(scale, scale, scale);
		}
		float limit = _limiter.Evaluate(_elapsed);
		if (_fadeElements != null)
		{
			for (int i = 0; i < _fadeElements.Length; i++)
			{
				FadeElement element = _fadeElements[i];
				if (element.Renderer == null)
				{
					continue;
				}
				float alpha = (element.FadeCurve != null) ? element.FadeCurve.Evaluate(_elapsed) : 0f;
				if (!_hasHelpMenu && i == _helpScreenIndex)
				{
					alpha = 0f;
				}
				element.Renderer.SetAlpha(Mathf.Min(alpha, limit));
			}
		}
		if (_elapsed >= _length)
		{
			gameObject.SetActive(false);
			return;
		}
		_elapsed += Time.deltaTime;
	}
}
