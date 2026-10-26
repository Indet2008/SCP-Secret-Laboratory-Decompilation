using System.Text;
using PlayerRoles.Subroutines;
using TMPro;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079AuxGui : Scp079BarBaseGui
	{
		[SerializeField]
		private TextMeshProUGUI _textBlockers;

		[SerializeField]
		private float _blockerHeaderSize;

		private Scp079AuxManager _auxManager;

		private StringBuilder _sb;

		private string _reducedHeader;

		private string _suspendedHeader;

		private const string Format = "{0} / {1}";

		protected override string Text => $"{_auxManager.CurrentAuxFloored} / {_auxManager.MaxAux}";

		protected override float FillAmount => _auxManager.CurrentAux / _auxManager.MaxAux;

		internal override void Init(Scp079Role role, ReferenceHub owner)
		{
			base.Init(role, owner);
			role.SubroutineModule.TryGetSubroutine<Scp079AuxManager>(out _auxManager);
			_sb = new StringBuilder(255);
			_reducedHeader = BuildHeader(Scp079HudTranslation.AuxRegenReduced);
			_suspendedHeader = BuildHeader(Scp079HudTranslation.AuxRegenSuspended);
		}

		private string BuildHeader(Scp079HudTranslation header)
		{
			_sb.Clear();
			_sb.Append("<size=");
			_sb.Append(_blockerHeaderSize);
			_sb.Append(">");
			_sb.Append(Translations.Get(header));
			_sb.Append("</size>");
			string text = _sb.ToString();
			RectTransform rectTransform = _textBlockers.rectTransform;
			rectTransform.sizeDelta = Vector2.Max(rectTransform.sizeDelta, _textBlockers.GetPreferredValues(text));
			return text;
		}

		protected override void Update()
		{
			base.Update();
			_sb.Clear();
			bool flag = false;
			float num = 1f;
			SubroutineBase[] allSubroutines = base.Role.SubroutineModule.AllSubroutines;
			for (int i = 0; i < allSubroutines.Length; i++)
			{
				if (allSubroutines[i] is IScp079AuxRegenModifier { AuxRegenMultiplier: var auxRegenMultiplier } scp079AuxRegenModifier && !(auxRegenMultiplier >= 1f))
				{
					flag = true;
					num *= auxRegenMultiplier;
					_sb.Append("\n");
					_sb.Append(scp079AuxRegenModifier.AuxReductionMessage);
				}
			}
			if (flag)
			{
				if (num <= 0f)
				{
					_sb.Insert(0, _suspendedHeader);
				}
				else
				{
					_sb.Insert(0, string.Format(_reducedHeader, num.ToString("0.##%")));
				}
			}
			_textBlockers.text = _sb.ToString();
		}
	}
}
