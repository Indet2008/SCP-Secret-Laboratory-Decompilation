using System.Text;
using NorthwoodLib.Pools;
using UnityEngine;

namespace InventorySystem.Drawers
{
	public readonly struct AlertContent
	{
		public enum ColorMode
		{
			White = 0,
			Role = 1,
			Accented = 2
		}

		public readonly bool Active;

		public readonly string Text;

		public readonly ColorMode SelectedColorMode;

		public readonly float Alpha;

		private const char ToggleAccentSymbol = '$';

		private const string StopColorTag = "</color>";

		public string ParseText(Color roleColor)
		{
			if (!Active)
			{
				return string.Empty;
			}
			return SelectedColorMode switch
			{
				ColorMode.Role => GetRoleColorTag(roleColor) + Text + "</color>", 
				ColorMode.White => GetWhiteColorTag() + Text + "</color>", 
				ColorMode.Accented => ParseAccented(roleColor), 
				_ => null, 
			};
		}

		private string ParseAccented(Color roleColor)
		{
			string whiteColorTag = GetWhiteColorTag();
			string roleColorTag = GetRoleColorTag(roleColor);
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent(whiteColorTag);
			bool flag = false;
			string text = Text;
			foreach (char c in text)
			{
				if (c != '$')
				{
					stringBuilder.Append(c);
					continue;
				}
				stringBuilder.Append("</color>");
				flag = !flag;
				if (flag)
				{
					stringBuilder.Append(roleColorTag);
				}
				else
				{
					stringBuilder.Append(whiteColorTag);
				}
			}
			stringBuilder.Append("</color>");
			return StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}

		private string GetRoleColorTag(Color roleColor)
		{
			roleColor.a = Alpha;
			return "<color=" + roleColor.ToHex() + ">";
		}

		private string GetWhiteColorTag()
		{
			Color color = new Color(1f, 1f, 1f, Alpha);
			return "<color=" + color.ToHex() + ">";
		}

		public AlertContent(string content, float alpha = 1f, ColorMode color = ColorMode.Accented)
		{
			Text = content;
			Alpha = alpha;
			SelectedColorMode = color;
			Active = !string.IsNullOrEmpty(content) && alpha > 0f;
		}
	}
}
