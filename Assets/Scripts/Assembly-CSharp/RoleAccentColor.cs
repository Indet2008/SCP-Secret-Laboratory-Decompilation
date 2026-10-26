using System;
using PlayerRoles;
using UnityEngine;

[Serializable]
public class RoleAccentColor
{
	[SerializeField]
	private Color _savedColor = Color.white;

	[SerializeField]
	private Color _fallbackColor = Color.white;

	[SerializeField]
	[Range(0f, 1f)]
	private float _minBrightness;

	[SerializeField]
	[Range(0f, 1f)]
	private float _maxBrightness = 1f;

	[Range(0f, 2f)]
	public float RoleColorInfluence = 1f;

	private Color _prevMixed = Color.white;

	private RoleTypeId _prevType = (RoleTypeId)sbyte.MinValue;

	private const RoleTypeId NoPrevRole = (RoleTypeId)sbyte.MinValue;

	public Color Color
	{
		get
		{
			if (RoleColorInfluence == 0f)
			{
				return ClampBrigtness(_savedColor);
			}
			bool flag;
			Color color;
			if (ReferenceHub.TryGetLocalHub(out var hub))
			{
				PlayerRoleBase currentRole = hub.roleManager.CurrentRole;
				flag = _prevType == currentRole.RoleTypeId;
				color = currentRole.RoleColor;
			}
			else
			{
				flag = false;
				color = _fallbackColor;
			}
			if (RoleColorInfluence == 2f)
			{
				return color;
			}
			if (!flag)
			{
				Color color2 = new Color(_savedColor.r * color.r, _savedColor.g * color.g, _savedColor.b * color.b, _savedColor.a * color.a);
				if (RoleColorInfluence == 1f)
				{
					_prevMixed = color2;
				}
				else if (RoleColorInfluence < 1f)
				{
					_prevMixed = Color.Lerp(_savedColor, color2, RoleColorInfluence);
				}
				else
				{
					_prevMixed = Color.Lerp(color2, color, RoleColorInfluence - 1f);
				}
				_prevMixed = ClampBrigtness(_prevMixed);
			}
			return _prevMixed;
		}
		set
		{
			_savedColor = value;
			_prevType = (RoleTypeId)sbyte.MinValue;
		}
	}

	private Color ClampBrigtness(Color color)
	{
		float grayscale = color.grayscale;
		if (grayscale < _minBrightness)
		{
			float num = _minBrightness - grayscale;
			return new Color(Mathf.Clamp01(color.r + num), Mathf.Clamp01(color.g + num), Mathf.Clamp01(color.b + num), color.a);
		}
		if (grayscale > _maxBrightness)
		{
			float num2 = _maxBrightness / grayscale;
			return new Color(Mathf.Clamp01(color.r * num2), Mathf.Clamp01(color.g * num2), Mathf.Clamp01(color.b * num2), color.a);
		}
		return color;
	}
}
