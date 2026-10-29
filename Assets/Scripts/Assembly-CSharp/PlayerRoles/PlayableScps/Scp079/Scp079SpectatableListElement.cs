using PlayerRoles.Spectating;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079SpectatableListElement : FullSizeSpectatableListElement
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::TMPro.TextMeshProUGUI _info;

		// Restored from the client build (IL2CPP): shows SCP-079's access tier and experience.
		private bool _hasTier;

		private string _format;

		private Scp079TierManager _tierManager;

		private readonly System.Text.StringBuilder _sb = new System.Text.StringBuilder();

		private void Awake()
		{
			_hasTier = false;
			_format = Translations.Get((Scp079HudTranslation)1);
		}

		protected override void OnTargetChanged(SpectatableModuleBase prevTarget, SpectatableModuleBase newTarget)
		{
			base.OnTargetChanged(prevTarget, newTarget);
			_hasTier = newTarget != null && newTarget.MainRole is Scp079Role role && role.SubroutineModule.TryGetSubroutine(out _tierManager);
		}

		protected override void Update()
		{
			base.Update();
			if (!_hasTier || _tierManager == null)
			{
				return;
			}
			_sb.Length = 0;
			_sb.AppendFormat(_format, _tierManager.AccessTierLevel);
			if (_tierManager.NextLevelThreshold > 0)
			{
				_sb.Append(" (");
				_sb.Append(_tierManager.RelativeExp);
				_sb.Append("/");
				_sb.Append(_tierManager.NextLevelThreshold);
				_sb.Append(")");
			}
			_info.text = _sb.ToString();
		}


	}
}
