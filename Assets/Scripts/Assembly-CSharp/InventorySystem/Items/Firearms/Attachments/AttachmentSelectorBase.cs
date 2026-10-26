using System;
using System.Collections.Generic;
using CameraShaking;
using InventorySystem.Items.Firearms.Attachments.Components;
using InventorySystem.Items.Firearms.Attachments.Formatters;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Items.Firearms.Attachments
{
	public abstract class AttachmentSelectorBase : MonoBehaviour
	{
		public static Action OnPresetLoaded;

		public static Action OnPresetSaved;

		public static Action OnAttachmentsReset;

		public Action OnSummaryToggled;

		protected AttachmentSlot SelectedSlot = AttachmentSlot.Unassigned;

		[SerializeField]
		protected MonoBehaviour[] SlotsPool;

		[SerializeField]
		protected MonoBehaviour[] SelectableAttachmentsPool;

		[SerializeField]
		private TextMeshProUGUI _attachmentName;

		[SerializeField]
		private TextMeshProUGUI _attachmentDescription;

		[SerializeField]
		private TextMeshProUGUI _pros;

		[SerializeField]
		private TextMeshProUGUI _cons;

		[SerializeField]
		private CanvasGroup _attachmentDimmer;

		[SerializeField]
		private float _dimmerSpeed;

		[SerializeField]
		private RawImage _bodyImage;

		[SerializeField]
		private RectTransform _fullscreenRect;

		[SerializeField]
		private RectTransform _sideRect;

		[SerializeField]
		private RectTransform _selectableRect;

		[SerializeField]
		private GameObject _selectorScreen;

		[SerializeField]
		private GameObject _summaryScreen;

		[SerializeField]
		private float _selectableMaxHeight;

		[SerializeField]
		private float _selectableMaxWidth;

		[SerializeField]
		private float _selectableMaxScale;

		[SerializeField]
		private float _maxDisplayedScale = 2f;

		[SerializeField]
		private RectTransform _configIcon;

		[SerializeField]
		private HorizontalOrVerticalLayoutGroup _selectableLayoutGroup;

		private Vector3 _targetScale;

		private Vector3 _targetPosition;

		private bool _isCorrectAttachment;

		private readonly List<GameObject> _spawnedConfigButtons = new List<GameObject>();

		private const byte SlotOffset = 32;

		private const string AttParamsFilename = "AttachmentParameters";

		public Firearm SelectedFirearm { get; protected set; }

		protected abstract bool UseLookatMode { get; set; }

		private static Vector3 SpinRotation => Vector3.back * Time.timeSinceLevelLoad * 100f;

		public void ProcessCollider(byte colId)
		{
			if (SelectedFirearm == null)
			{
				return;
			}
			RefreshState(SelectedFirearm, colId);
			if (colId >= 32)
			{
				SelectedSlot = (AttachmentSlot)(colId - 32);
				if (UseLookatMode)
				{
					RefreshState(SelectedFirearm, colId);
				}
			}
			else
			{
				SelectAttachmentId(colId);
			}
		}

		public void ShowStats(int attachmentId)
		{
			_isCorrectAttachment = attachmentId >= 0 && attachmentId < SelectedFirearm.Attachments.Length;
			if (!_isCorrectAttachment)
			{
				return;
			}
			Attachment attachment = SelectedFirearm.Attachments[attachmentId];
			attachment.GetNameAndDescription(out var n, out var d);
			_pros.text = string.Empty;
			_cons.text = string.Empty;
			_attachmentName.text = n;
			_attachmentDescription.text = d;
			for (int i = 0; i < AttachmentsUtils.TotalNumberOfParams; i++)
			{
				attachment.GetParameterData(i, out var val, out var state);
				if ((state & AttachmentParamState.UserInterface) == 0)
				{
					continue;
				}
				AttachmentParam attachmentParam = (AttachmentParam)i;
				if (AttachmentParameterFormatters.Formatters.TryGetValue(attachmentParam, out var value) && value.FormatParameter(attachmentParam, SelectedFirearm, attachmentId, val, out var formattedText, out var isGood))
				{
					bool flag = TranslationReader.TryGet("AttachmentParameters", i, out var val2);
					string text = "\n" + (flag ? val2 : attachmentParam.ToString()) + ": " + formattedText;
					if (isGood)
					{
						_pros.text += text;
					}
					else
					{
						_cons.text += text;
					}
				}
			}
			NonParameterFormatter.Format(SelectedFirearm, attachmentId, out var pros, out var cons);
			_pros.text += pros;
			_cons.text += cons;
		}

		protected abstract void LoadPreset(uint loadedCode);

		protected abstract void SelectAttachmentId(byte attachmentId);

		public abstract void RegisterAction(RectTransform t, Action<Vector2> action);

		public bool CanSaveAsPreference(int presetId)
		{
			if (presetId == 0 || SelectedFirearm == null)
			{
				return false;
			}
			uint currentAttachmentsCode = SelectedFirearm.GetCurrentAttachmentsCode();
			return AttachmentPreferences.GetPreferenceCodeOfPreset(SelectedFirearm.ItemTypeId, presetId) != currentAttachmentsCode;
		}

		public void SaveAsPreset(int presetId)
		{
			if (CanSaveAsPreference(presetId))
			{
				AttachmentPreferences.SetPreset(SelectedFirearm.ItemTypeId, presetId);
				SelectedFirearm.SavePreferenceCode();
				OnPresetSaved?.Invoke();
			}
		}

		public void LoadPreset(int presetId)
		{
			AttachmentPreferences.SetPreset(SelectedFirearm.ItemTypeId, presetId);
			if (presetId != 0)
			{
				LoadPreset(SelectedFirearm.GetSavedPreferenceCode());
				OnPresetLoaded?.Invoke();
			}
		}

		public void ResetAttachments()
		{
			AttachmentPreferences.SetPreset(SelectedFirearm.ItemTypeId, 0);
			LoadPreset(SelectedFirearm.ValidateAttachmentsCode(0u));
			OnAttachmentsReset?.Invoke();
		}

		public void ToggleSummaryScreen(bool summary)
		{
			_summaryScreen.SetActive(summary);
			_selectorScreen.SetActive(!summary);
			OnSummaryToggled?.Invoke();
		}

		public void ToggleSummaryScreen()
		{
			ToggleSummaryScreen(!_summaryScreen.activeSelf);
		}

		protected void LerpRects(float lerpState)
		{
			_bodyImage.rectTransform.localScale = Vector3.Lerp(_bodyImage.rectTransform.localScale, _targetScale, lerpState);
			_bodyImage.rectTransform.localPosition = Vector3.Lerp(_bodyImage.rectTransform.localPosition, _targetPosition, lerpState);
		}

		private void Lookat(Vector3 pos)
		{
			CameraShakeController.AddEffect(new LookatShake(pos));
		}

		private void DisableAllSelectableAttachments()
		{
			MonoBehaviour[] selectableAttachmentsPool = SelectableAttachmentsPool;
			for (int i = 0; i < selectableAttachmentsPool.Length; i++)
			{
				((IAttachmentSelectorButton)selectableAttachmentsPool[i]).RectTransform.gameObject.SetActive(value: false);
			}
		}

		protected bool RefreshState(Firearm firearm, byte? refreshReason)
		{
			_spawnedConfigButtons.ForEach((GameObject x) =>
			{
				UnityEngine.Object.Destroy(x.gameObject);
			});
			_spawnedConfigButtons.Clear();
			if (firearm != SelectedFirearm)
			{
				SelectedFirearm = firearm;
				SelectedSlot = AttachmentSlot.Unassigned;
				_bodyImage.rectTransform.localScale = Vector3.zero;
				DisableAllSelectableAttachments();
				if (firearm == null)
				{
					return false;
				}
				if (SelectedFirearm.GetSavedPreferenceCode() != SelectedFirearm.GetCurrentAttachmentsCode())
				{
					AttachmentPreferences.SetPreset(SelectedFirearm.ItemTypeId, 0);
				}
			}
			if (firearm == null)
			{
				return false;
			}
			_attachmentDimmer.alpha = Mathf.Clamp01(_attachmentDimmer.alpha + Time.deltaTime * (_isCorrectAttachment ? _dimmerSpeed : (0f - _dimmerSpeed)));
			_bodyImage.texture = firearm.BodyIconTexture;
			_bodyImage.rectTransform.sizeDelta = new Vector2(firearm.BodyIconTexture.width, firearm.BodyIconTexture.height);
			int num = 0;
			for (int num2 = 0; num2 < firearm.Attachments.Length; num2++)
			{
				IAttachmentSelectorButton component = SlotsPool[num].GetComponent<IAttachmentSelectorButton>();
				if (!firearm.Attachments[num2].IsEnabled || !(firearm.Attachments[num2] is IDisplayableAttachment { IconOffset: var vector } displayableAttachment))
				{
					continue;
				}
				if (firearm.Attachments[Mathf.Clamp(displayableAttachment.ParentId, 0, firearm.Attachments.Length)].IsEnabled)
				{
					vector += displayableAttachment.ParentOffset;
				}
				component.RectTransform.gameObject.SetActive(value: true);
				component.Setup(displayableAttachment.Icon, firearm.Attachments[num2].Slot, vector, firearm);
				component.ButtonId = (byte)(32 + firearm.Attachments[num2].Slot);
				ICustomizableAttachment ica = displayableAttachment as ICustomizableAttachment;
				if (ica != null)
				{
					RectTransform rectTransform = UnityEngine.Object.Instantiate(_configIcon, component.RectTransform);
					rectTransform.localScale *= ica.ConfigIconScale / rectTransform.localScale.x;
					rectTransform.localRotation = Quaternion.Euler(SpinRotation);
					rectTransform.localPosition = ica.ConfigIconOffset;
					rectTransform.gameObject.SetActive(value: true);
					_spawnedConfigButtons.Add(rectTransform.gameObject);
					Attachment att = firearm.Attachments[num2];
					RegisterAction(rectTransform, (Vector2 _) =>
					{
						RectTransform component3 = _selectorScreen.GetComponent<RectTransform>();
						AttachmentConfigWindow attachmentConfigWindow = UnityEngine.Object.Instantiate(ica.ConfigWindow, component3.parent);
						attachmentConfigWindow.Setup(this, att, component3);
						attachmentConfigWindow.OnDestroyed = (Action)Delegate.Combine(attachmentConfigWindow.OnDestroyed, (Action)(() =>
						{
							ToggleSummaryScreen(summary: false);
						}));
					});
				}
				num++;
				if (UseLookatMode)
				{
					LerpRects(1f);
					if (refreshReason.HasValue && refreshReason.Value < 32 && firearm.Attachments[refreshReason.Value].Slot == firearm.Attachments[num2].Slot)
					{
						Lookat(component.RectTransform.transform.position);
					}
				}
			}
			for (int num3 = num; num3 < SlotsPool.Length; num3++)
			{
				SlotsPool[num3].gameObject.SetActive(value: false);
			}
			DisableAllSelectableAttachments();
			if (SelectedSlot == AttachmentSlot.Unassigned)
			{
				FitToRect(_fullscreenRect);
			}
			else
			{
				int num4 = 0;
				float num5 = 0f;
				float num6 = 0f;
				Transform transform = null;
				for (byte b = 0; b < firearm.Attachments.Length; b++)
				{
					if (firearm.Attachments[b].Slot == SelectedSlot && SelectableAttachmentsPool[num4].TryGetComponent<IAttachmentSelectorButton>(out var component2) && firearm.Attachments[b] is IDisplayableAttachment displayableAttachment2)
					{
						component2.RectTransform.gameObject.SetActive(value: true);
						component2.ButtonId = b;
						component2.Setup(displayableAttachment2.Icon, AttachmentSlot.Unassigned, null, firearm);
						num6 = Mathf.Max(num6, component2.RectTransform.sizeDelta.y);
						num5 += component2.RectTransform.sizeDelta.x;
						if (UseLookatMode && refreshReason.HasValue && refreshReason.Value - 32 == (int)SelectedSlot && firearm.Attachments[b].IsEnabled)
						{
							transform = component2.RectTransform.transform;
						}
						num4++;
					}
				}
				float num7 = Mathf.Max(1f / _selectableMaxScale, Mathf.Max(num5 / _selectableMaxWidth, num6 / _selectableMaxHeight));
				MonoBehaviour[] selectableAttachmentsPool = SelectableAttachmentsPool;
				for (int num8 = 0; num8 < selectableAttachmentsPool.Length; num8++)
				{
					IAttachmentSelectorButton attachmentSelectorButton = (IAttachmentSelectorButton)selectableAttachmentsPool[num8];
					if (attachmentSelectorButton.RectTransform.gameObject.activeSelf)
					{
						attachmentSelectorButton.RectTransform.sizeDelta /= num7;
					}
				}
				FitToRect(_sideRect);
				if (transform != null)
				{
					_selectableLayoutGroup.SetLayoutVertical();
					LerpRects(1f);
					Lookat(transform.transform.position);
				}
			}
			return true;
		}

		protected virtual void OnDisable()
		{
			_isCorrectAttachment = false;
			_attachmentDimmer.alpha = 0f;
		}

		private void FitToRect(RectTransform rt)
		{
			Vector3 localScale = _bodyImage.rectTransform.localScale;
			Vector3 localPosition = _bodyImage.rectTransform.localPosition;
			Bounds b = default;
			_bodyImage.rectTransform.localScale = Vector3.one;
			_bodyImage.rectTransform.localPosition = Vector3.zero;
			Encapsulate(ref b, _bodyImage.rectTransform);
			MonoBehaviour[] slotsPool = SlotsPool;
			for (int i = 0; i < slotsPool.Length; i++)
			{
				IAttachmentSelectorButton attachmentSelectorButton = (IAttachmentSelectorButton)slotsPool[i];
				if (attachmentSelectorButton.RectTransform.gameObject.activeSelf)
				{
					Encapsulate(ref b, attachmentSelectorButton.RectTransform);
				}
			}
			Vector3 vector = b.center - _bodyImage.rectTransform.localPosition;
			float num = Mathf.Min(_maxDisplayedScale, Mathf.Min(rt.sizeDelta.x / b.size.x, rt.sizeDelta.y / b.size.y));
			_targetScale = Vector3.one * num;
			_targetPosition = rt.localPosition - vector * num;
			_bodyImage.rectTransform.localScale = localScale;
			_bodyImage.rectTransform.localPosition = localPosition;
		}

		private void Encapsulate(ref Bounds b, RectTransform rct)
		{
			Vector2 vector = rct.sizeDelta / 2f;
			b.Encapsulate(rct.localPosition + Vector3.up * vector.y + Vector3.left * vector.x);
			b.Encapsulate(rct.localPosition + Vector3.down * vector.y + Vector3.right * vector.x);
		}
	}
}
