using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using Interactables.Interobjects.DoorUtils;
using InventorySystem.Items.Keycards.Snake;
using MEC;
using Mirror;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Items.Keycards
{
	public class ChaosKeycardViewmodel : KeycardViewmodel
	{
		[Serializable]
		private class LedColumn
		{
			public string LabelPrefix;

			[SerializeField]
			private LedDiode[] _diodes;

			[SerializeField]
			private bool _maskContainment;

			[SerializeField]
			private bool _maskArmory;

			[SerializeField]
			private bool _maskAdmin;

			private int _highestLevel;

			private KeycardLevels LevelMask => new KeycardLevels(_maskContainment ? 3 : 0, _maskArmory ? 3 : 0, _maskAdmin ? 3 : 0);

			private DoorPermissionFlags PermsMask => LevelMask.Permissions;

			public void Init(Renderer rend, DoorPermissionFlags keycardPerms)
			{
				_highestLevel = new KeycardLevels(PermsMask & keycardPerms).HighestLevelValue;
				for (int i = 0; i < _diodes.Length; i++)
				{
					LedDiode ledDiode = _diodes[i];
					ledDiode.PropertyBlock = new MaterialPropertyBlock();
					rend.GetPropertyBlock(ledDiode.PropertyBlock, ledDiode.MaterialId);
					ledDiode.HasPermission = i < _highestLevel;
				}
			}

			public void SetColorIdle(Color inactive, Color active)
			{
				LedDiode[] diodes = _diodes;
				foreach (LedDiode obj in diodes)
				{
					obj.SetColor(obj.HasPermission ? active : inactive);
				}
			}

			public string SetPermissionColor(int index, Color active, Color inactive, Color denied, Color granted, DoorPermissionFlags requiredPerms)
			{
				int highestLevelValue = new KeycardLevels(requiredPerms & PermsMask).HighestLevelValue;
				int num = index + 1;
				LedDiode ledDiode = _diodes[index];
				if (num > highestLevelValue)
				{
					ledDiode.SetColor(ledDiode.HasPermission ? active : inactive);
					return null;
				}
				if (num > _highestLevel)
				{
					ledDiode.SetColor(denied);
					return "\nEMULATING SIGNAL " + LabelPrefix + num + "...  [ FAILED ]";
				}
				ledDiode.SetColor(granted);
				return "\nEMULATING SIGNAL " + LabelPrefix + num + "...  [ SUCCESS ]";
			}

			public void UpdateGfx(Renderer renderer)
			{
				LedDiode[] diodes = _diodes;
				foreach (LedDiode ledDiode in diodes)
				{
					if (ledDiode.Modified)
					{
						ledDiode.Modified = false;
						renderer.SetPropertyBlock(ledDiode.PropertyBlock, ledDiode.MaterialId);
					}
				}
			}
		}

		[Serializable]
		private class LedDiode
		{
			private static readonly int ColorHash = Shader.PropertyToID("_EmissiveColor");

			private Color? _lastColor;

			public int MaterialId;

			public bool Modified { get; set; }

			public bool HasPermission { get; set; }

			public MaterialPropertyBlock PropertyBlock { get; set; }

			public void SetColor(Color color)
			{
				if (!(_lastColor == color))
				{
					PropertyBlock.SetColor(ColorHash, color);
					Modified = true;
					_lastColor = color;
				}
			}
		}

		private static readonly int ButtonTriggerHash = Animator.StringToHash("ButtonTrigger");

		private static readonly int ButtonDirXHash = Animator.StringToHash("ButtonDirectionX");

		private static readonly int ButtonDirYHash = Animator.StringToHash("ButtonDirectionY");

		public const float SnakeBootupTime = 1.7f;

		private const int IdleLayer = 1;

		[Multiline]
		[SerializeField]
		private string _defaultText;

		[SerializeField]
		private SnakeDisplay _snakeDisplay;

		[SerializeField]
		private GameObject _loadingRoot;

		[SerializeField]
		private GameObject _normalRoot;

		[SerializeField]
		private Slider _loadingSlider;

		[SerializeField]
		private LedColumn[] _diodes;

		[SerializeField]
		private TMP_Text _consoleText;

		[SerializeField]
		[ColorUsage(false, true)]
		private Color _diodeOff;

		[SerializeField]
		[ColorUsage(false, true)]
		private Color _diodeBlue;

		[SerializeField]
		[ColorUsage(false, true)]
		private Color _diodeGreen;

		[SerializeField]
		[ColorUsage(false, true)]
		private Color _diodeRed;

		[SerializeField]
		[ColorUsage(false, true)]
		private Color _diodeNeutral;

		[SerializeField]
		private Renderer _diodeRenderer;

		private CoroutineHandle _lastHandle;

		private DoorPermissionFlags _animReqPerms;

		private string _animReqName;

		public override void InitAny()
		{
			base.InitAny();
			ChaosKeycardItem.OnSnakeMovementDirChanged += OnDirChanged;
			ChaosKeycardItem.OnDetailedUse += OnDetailedUse;
			TryGetPermissions(out var perms);
			LedColumn[] diodes = _diodes;
			for (int i = 0; i < diodes.Length; i++)
			{
				diodes[i].Init(_diodeRenderer, perms);
			}
			SetIdle();
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			ChaosKeycardItem.OnSnakeMovementDirChanged -= OnDirChanged;
			ChaosKeycardItem.OnDetailedUse -= OnDetailedUse;
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			SetIdle();
		}

		private void OnDetailedUse(ushort serial, DoorPermissionFlags flags, string reqName)
		{
			if (serial == base.ItemId.SerialNumber)
			{
				_animReqPerms = flags;
				_animReqName = Regex.Replace(reqName, "([a-z0-9])([A-Z])", "$1_$2").ToUpperInvariant();
				_lastHandle.IsRunning = false;
				_lastHandle = Timing.RunCoroutine(UseAnimation().CancelWith(base.gameObject), Segment.Update);
			}
		}

		private void OnDirChanged(ushort? netSerial, Vector2Int dir)
		{
			if (base.IsLocal)
			{
				if (netSerial.HasValue)
				{
					return;
				}
			}
			else if (netSerial != base.ItemId.SerialNumber)
			{
				return;
			}
			AnimatorSetInt(ButtonDirXHash, dir.x);
			AnimatorSetInt(ButtonDirYHash, dir.y);
			AnimatorSetTrigger(ButtonTriggerHash);
		}

		private void SetRoot(UnityEngine.Object targetActive, float idleWeight = 1f)
		{
			AnimatorSetLayerWeight(1, idleWeight);
			_loadingRoot.SetActive((object)targetActive == _loadingRoot);
			_normalRoot.SetActive((object)targetActive == _normalRoot);
			_snakeDisplay.gameObject.SetActive((object)targetActive == _snakeDisplay);
		}

		private void SetIdle()
		{
			_consoleText.text = _defaultText;
			LedColumn[] diodes = _diodes;
			for (int i = 0; i < diodes.Length; i++)
			{
				diodes[i].SetColorIdle(_diodeOff, _diodeBlue);
			}
		}

		private IEnumerator<float> UseAnimation()
		{
			SetIdle();
			_consoleText.text = "INITIATOR DETECTED [ 13.56 MHz ] \nSIGNATURE: " + _animReqName + " \n\nTRANSCEIVING...";
			for (int i = 0; i < 3; i++)
			{
				yield return Timing.WaitForSeconds(0.2f);
				LedColumn[] diodes = _diodes;
				for (int j = 0; j < diodes.Length; j++)
				{
					string text = diodes[j].SetPermissionColor(i, _diodeBlue, _diodeOff, _diodeRed, _diodeGreen, _animReqPerms);
					if (!string.IsNullOrEmpty(text))
					{
						_consoleText.text += text;
					}
				}
			}
			_consoleText.text += "\n\nEMULATION STOPPING...";
			yield return Timing.WaitForSeconds(1.8f);
			SetIdle();
		}

		private bool TryGetPermissions(out DoorPermissionFlags perms)
		{
			if (base.ItemId.TryGetTemplate<KeycardItem>(out var item))
			{
				perms = item.GetPermissions(null);
				return true;
			}
			perms = DoorPermissionFlags.None;
			return false;
		}

		protected override void LateUpdate()
		{
			base.LateUpdate();
			LedColumn[] diodes = _diodes;
			for (int i = 0; i < diodes.Length; i++)
			{
				diodes[i].UpdateGfx(_diodeRenderer);
			}
			if (!KeycardItem.StartInspectTimes.TryGetValue(base.ItemId.SerialNumber, out var value))
			{
				SetRoot(_normalRoot);
				return;
			}
			float num = (float)(NetworkTime.time - value) / 1.7f;
			if (num < 1f)
			{
				SetRoot(_loadingRoot, Mathf.Clamp01(1f - num));
				_loadingSlider.value = EaseInUtils.ChoppyLoading(num, 0.1666666716337204);
			}
			else
			{
				SetRoot(_snakeDisplay, 0f);
			}
		}
	}
}
