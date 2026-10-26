using System;

[Serializable]
public class UserGroup
{
	public string Name;

	public string BadgeColor;

	public string BadgeText;

	public ulong Permissions;

	public bool Cover;

	public bool HiddenByDefault;

	public bool Shared;

	public byte KickPower;

	public byte RequiredKickPower;

	public UserGroup Clone()
	{
		return new UserGroup
		{
			Name = Name,
			BadgeColor = BadgeColor,
			BadgeText = BadgeText,
			Permissions = Permissions,
			Cover = Cover,
			HiddenByDefault = HiddenByDefault,
			Shared = Shared,
			KickPower = KickPower,
			RequiredKickPower = RequiredKickPower
		};
	}
}
