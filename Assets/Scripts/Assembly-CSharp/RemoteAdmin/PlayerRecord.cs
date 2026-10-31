using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace RemoteAdmin
{
	public class PlayerRecord : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
	{
		private static readonly int OutlineWidthId = Shader.PropertyToID("_OutlineWidth");

		private static readonly int OutlineColorId = Shader.PropertyToID("_OutlineColor");

		private const float SelectedOutlineWidth = 0.5f;

		[SerializeField]
		private TMP_Text _textComponent;

		private bool _hasLink;

		private bool _isSelected;

		private bool _registered;

		public static string LastSelectedId { get; internal set; }

		public static List<PlayerRecord> Instances { get; } = new List<PlayerRecord>();

		public string PlayerId { get; set; }

		public bool IsSelected
		{
			get
			{
				return _isSelected;
			}
			set
			{
				_isSelected = value;
				UpdateGraphic();
			}
		}

		internal void Register()
		{
			if (!_registered)
			{
				_registered = true;
				Instances.Add(this);
			}
		}

		public void OnPointerDown(PointerEventData _)
		{
			bool pressingControl = Input.GetKey(KeyCode.LeftControl) || Input.GetKey(KeyCode.RightControl);
			bool pressingShift = Input.GetKey(KeyCode.LeftShift) || Input.GetKey(KeyCode.RightShift);
			OnMouseSelect(!_isSelected, pressingControl, pressingShift);
		}

		internal void SetState(bool selected, bool allowMultipleSelection = false, bool changeLastSelected = true)
		{
			if (!allowMultipleSelection)
			{
				foreach (PlayerRecord instance in Instances)
				{
					if (instance != null && instance != this && instance._isSelected)
					{
						instance.IsSelected = false;
					}
				}
			}
			IsSelected = selected;
			if (changeLastSelected)
			{
				LastSelectedId = PlayerId;
			}
		}

		internal void SetText(string content)
		{
			if (!(_textComponent == null))
			{
				_textComponent.text = content;
				_hasLink = content.Contains("<link=RA_");
			}
		}

		private void OnMouseSelect(bool newState, bool pressingControl = false, bool pressingShift = false)
		{
			if (!pressingShift || string.IsNullOrEmpty(LastSelectedId))
			{
				SetState(newState, pressingControl);
				return;
			}
			int num = Instances.FindIndex((PlayerRecord x) => x != null && x.PlayerId == LastSelectedId);
			int num2 = Instances.IndexOf(this);
			if (num < 0 || num2 < 0)
			{
				SetState(newState, pressingControl);
				return;
			}
			if (!pressingControl)
			{
				foreach (PlayerRecord instance in Instances)
				{
					if (instance != null)
					{
						instance.IsSelected = false;
					}
				}
			}
			int num3 = Math.Min(num, num2);
			int num4 = Math.Max(num, num2);
			for (int i = num3; i <= num4; i++)
			{
				if (Instances[i] != null)
				{
					Instances[i].IsSelected = true;
				}
			}
		}

		private IEnumerable<PlayerRecord> ToSelect(int oldIndex, int newIndex)
		{
			return System.Linq.Enumerable.Take(System.Linq.Enumerable.Skip(Instances, oldIndex), newIndex - oldIndex);
		}

		private void Update()
		{
			if (!_hasLink || _textComponent == null || RemoteAdminUIController.Singleton == null)
			{
				return;
			}
			int num = TMP_TextUtilities.FindIntersectingLink(_textComponent, Input.mousePosition, null);
			if (num < 0 || _textComponent.textInfo == null || num >= _textComponent.textInfo.linkInfo.Length)
			{
				return;
			}
			string linkID = _textComponent.textInfo.linkInfo[num].GetLinkID();
			string text = linkID switch
			{
				"RA_RaEverywhere" => "This player is a Northwood Studios GLOBAL staff member.",
				"RA_StudioStaff" => "This player is a Northwood Studios staff member.",
				"RA_Admin" => "This player is an administrator logged in to Remote Admin.",
				"RA_OverwatchEnabled" => "This player has overwatch mode enabled.",
				"RA_Muted" => "This player is muted.",
				"RA_HiddenSpectatable" => "This player is hidden from spectators.",
				_ => null,
			};
			if (text != null)
			{
				RemoteAdminUIController.Singleton.SetToolTip(text);
			}
		}

		private void UpdateGraphic()
		{
			if (_textComponent == null)
			{
				return;
			}
			// Original: only the outline width changes (0 <-> 0.5, outline colour comes from the font material);
			// the object is re-enabled so TMP rebuilds the mesh.
			Material fontMaterial = _textComponent.fontMaterial;
			float @float = fontMaterial.GetFloat(OutlineWidthId);
			if (_isSelected ? (@float == 0f) : (@float == SelectedOutlineWidth))
			{
				_textComponent.gameObject.SetActive(value: false);
				fontMaterial.SetFloat(OutlineWidthId, _isSelected ? SelectedOutlineWidth : 0f);
				_textComponent.gameObject.SetActive(value: true);
			}
		}
		private void Start()
		{
			if (_textComponent == null)
			{
				return;
			}
			// Original: white outline on the record's own font material, width 0.5 only while selected.
			_textComponent.gameObject.SetActive(value: false);
			Material fontMaterial = _textComponent.fontMaterial;
			fontMaterial.SetFloat(OutlineWidthId, _isSelected ? SelectedOutlineWidth : 0f);
			fontMaterial.SetColor(OutlineColorId, Color.white);
			_textComponent.gameObject.SetActive(value: true);
		}

		private void OnDestroy()
		{
			Instances.Remove(this);
		}
	}
}
