using System;
using System.Collections.Generic;
using Interactables.Interobjects.DoorUtils;
using MEC;
using UnityEngine;

namespace Interactables.Interobjects.DoorButtons
{
	public class KeycardScannerPermsIndicator : MonoBehaviour
	{
		private readonly struct MaterialVariant : IEquatable<MaterialVariant>
		{
			public readonly Color32 Color;

			public readonly Vector2 Offset;

			public MaterialVariant(Color32 color, Vector2 offset)
			{
				Offset = offset;
				Color = new Color32(color.r, color.g, color.b, byte.MaxValue);
			}

			public Material CreateVariant(Material template)
			{
				Material material = new Material(template);
				material.SetTextureOffset(EmissionTextureHash, Offset);
				material.SetColor(EmissionColorHash, Color);
				material.mainTextureOffset = Offset;
				return material;
			}

			public bool Equals(MaterialVariant other)
			{
				if (Color.Equals(other.Color))
				{
					return Offset == other.Offset;
				}
				return false;
			}

			public override bool Equals(object obj)
			{
				if (obj is MaterialVariant other)
				{
					return Equals(other);
				}
				return false;
			}

			public override int GetHashCode()
			{
				return HashCode.Combine(Color, Offset);
			}
		}

		private static readonly Dictionary<MaterialVariant, Material> MaterialVariants = new Dictionary<MaterialVariant, Material>();

		private static readonly int EmissionTextureHash = Shader.PropertyToID("_EmissiveColorMap");

		private static readonly int EmissionColorHash = Shader.PropertyToID("_EmissiveColor");

		private static readonly Vector2 PermsOffsetContainment = new Vector2(0f, 0.5f);

		private static readonly Vector2 PermsOffsetArmory = new Vector2(0.5f, 0.5f);

		private static readonly Vector2 PermsOffsetAdmin = new Vector2(0f, 0f);

		private static readonly Color32 DefaultColor = new Color32(0, 72, 200, byte.MaxValue);

		private static readonly Color32 RedColor = Color.red;

		private static readonly Color32 GreenColor = Color.green;

		private static readonly Color32 InactiveColor = new Color32(10, 10, 15, byte.MaxValue);

		[SerializeField]
		private Material _trimMaterialTemplate;

		[SerializeField]
		private Renderer[] _targetIcons;

		[SerializeField]
		private int _minBlinkDelay;

		[SerializeField]
		private DoorPermissionFlags _ignoredPerms;

		private Material _defaultMat;

		private Material _redMat;

		private Material _greenMat;

		private Material _inactiveMat;

		private CoroutineHandle _lastHandle;

		private DoorPermissionFlags _requiredPerms;

		private int _requiredLevel;

		private int _lastAnimLevel;

		private bool _lastAccepted;

		private float? _lastAnimTime;

		public void Register(IDoorPermissionRequester requester)
		{
			_requiredPerms = requester.PermissionsPolicy.RequiredPermissions;
			KeycardLevels keycardLevels = new KeycardLevels((DoorPermissionFlags)((uint)_requiredPerms & (uint)(ushort)(~(int)_ignoredPerms)));
			Vector2 offset;
			if (keycardLevels.Containment > 0)
			{
				_requiredLevel = keycardLevels.Containment;
				offset = PermsOffsetContainment;
			}
			else if (keycardLevels.Armory > 0)
			{
				_requiredLevel = keycardLevels.Armory;
				offset = PermsOffsetArmory;
			}
			else
			{
				_requiredLevel = keycardLevels.Admin;
				offset = PermsOffsetAdmin;
			}
			_defaultMat = GetSharedMaterial(DefaultColor, offset);
			_redMat = GetSharedMaterial(RedColor, offset);
			_greenMat = GetSharedMaterial(GreenColor, offset);
			_inactiveMat = GetSharedMaterial(InactiveColor, offset);
			ShowIdle();
		}

		public void ShowIdle()
		{
			if (_lastHandle.IsRunning)
			{
				Timing.KillCoroutines(_lastHandle);
			}
			for (int i = 0; i < _targetIcons.Length; i++)
			{
				Material sharedMaterial = ((i >= _requiredLevel) ? _inactiveMat : _defaultMat);
				_targetIcons[i].sharedMaterial = sharedMaterial;
			}
			base.enabled = false;
		}

		public void PlayAccepted(float? duration)
		{
			_lastAccepted = true;
			_lastAnimLevel = _requiredLevel;
			_lastAnimTime = duration;
			Play();
		}

		public void PlayDenied(DoorPermissionFlags flags, float? duration)
		{
			KeycardLevels keycardLevels = new KeycardLevels(new KeycardLevels((DoorPermissionFlags)((uint)_requiredPerms & (uint)(ushort)(~(int)_ignoredPerms))).Permissions & flags);
			_lastAccepted = false;
			_lastAnimLevel = keycardLevels.HighestLevelValue;
			_lastAnimTime = duration;
			Play();
		}

		private void Play()
		{
			base.enabled = true;
			if (_lastHandle.IsRunning)
			{
				Timing.KillCoroutines(_lastHandle);
			}
			_lastHandle = Timing.RunCoroutine(PlayAnimation().CancelWith(base.gameObject), Segment.Update);
		}

		private IEnumerator<float> PlayAnimation()
		{
			double timestamp = Time.timeAsDouble;
			Renderer[] targetIcons = _targetIcons;
			for (int i = 0; i < targetIcons.Length; i++)
			{
				targetIcons[i].sharedMaterial = _inactiveMat;
			}
			yield return Timing.WaitForSeconds(0.1f);
			Material targetMat = (_lastAccepted ? _greenMat : _redMat);
			for (int j = 0; j < Mathf.Max(_lastAnimLevel, _minBlinkDelay); j++)
			{
				if (j < _lastAnimLevel && _targetIcons.TryGet(j, out var element))
				{
					element.sharedMaterial = targetMat;
				}
				yield return Timing.WaitForSeconds(0.1f);
			}
			int blinkStartIndex = ((!_lastAccepted) ? _lastAnimLevel : 0);
			int blinkEndIndex = Mathf.Min(_targetIcons.Length, _requiredLevel);
			for (int j = 0; j < 6; j++)
			{
				Material sharedMaterial = ((j % 2 == 1) ? targetMat : _inactiveMat);
				for (int k = blinkStartIndex; k < blinkEndIndex; k++)
				{
					_targetIcons[k].sharedMaterial = sharedMaterial;
				}
				yield return Timing.WaitForSeconds(0.1f);
			}
			if (_lastAnimTime.HasValue)
			{
				double num = Time.timeAsDouble - timestamp;
				double num2 = (double)_lastAnimTime.Value - num;
				yield return Timing.WaitForSeconds((float)num2);
				ShowIdle();
			}
		}

		private Material GetSharedMaterial(Color32 color, Vector2 offset)
		{
			MaterialVariant key = new MaterialVariant(color, offset);
			if (!MaterialVariants.TryGetValue(key, out var value))
			{
				value = key.CreateVariant(_trimMaterialTemplate);
				MaterialVariants.Add(key, value);
			}
			return value;
		}
	}
}
