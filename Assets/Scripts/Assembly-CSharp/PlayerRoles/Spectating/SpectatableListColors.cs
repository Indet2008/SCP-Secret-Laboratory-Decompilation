using UnityEngine;

namespace PlayerRoles.Spectating
{
	public static class SpectatableListColors
	{
		public static readonly Color BgRegular = new Color(0.161f, 0.161f, 0.161f, 0.761f);

		public static readonly Color BgSelected = new Color(0.161f, 0.161f, 0.161f, 1f);

		public static readonly Color Nickname = new Color(0.518f, 0.518f, 0.518f, 1f);

		public static readonly Color Shield = new Color(0.682f, 0.682f, 0.682f, 1f);

		public static Color MixAvatarColor(Color roleColor)
		{
			return Color.Lerp(b: new Color(0.443f, 0.443f, 0.443f, 1f), a: roleColor.linear, t: 0.63f);
		}
	}
}
