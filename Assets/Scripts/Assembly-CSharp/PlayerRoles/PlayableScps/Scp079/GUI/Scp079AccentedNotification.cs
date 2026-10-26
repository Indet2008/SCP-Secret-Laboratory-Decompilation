using System.Text;
using NorthwoodLib.Pools;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079AccentedNotification : Scp079SimpleNotification
	{
		public const char ToggleChar = '$';

		public const string AccentColor = "#00a2ff";

		private const string FormatStartColor = "<color={0}>";

		private const string FormatEndColor = "</color>";

		public Scp079AccentedNotification(string message, string color = "#00a2ff", char triggerChar = '$')
			: base(ProcessText(message, color, triggerChar))
		{
		}

		private static string ProcessText(string message, string color, char triggerChar)
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			bool flag = false;
			string text = $"<color={color}>";
			foreach (char c in message)
			{
				if (c != triggerChar)
				{
					stringBuilder.Append(c);
					continue;
				}
				stringBuilder.Append(flag ? "</color>" : text);
				flag = !flag;
			}
			if (flag)
			{
				stringBuilder.Append("</color>");
			}
			return StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}
	}
}
