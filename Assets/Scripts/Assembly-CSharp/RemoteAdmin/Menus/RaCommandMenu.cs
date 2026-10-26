using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using RemoteAdmin.Elements;
using TMPro;
using Tooltips;
using UnityEngine;

namespace RemoteAdmin.Menus
{
	public class RaCommandMenu : MonoBehaviour, ITooltipHolder
	{
		[field: SerializeField]
		protected string DefaultFormat { get; set; } = "{0} {1} {2}";

		[field: SerializeField]
		public List<ValueButton> Options { get; set; } = new List<ValueButton>();

		[field: SerializeField]
		protected TMP_InputField InputFieldText { get; set; }

		[field: SerializeField]
		public TooltipData[] StoredInfo { get; set; }

		[field: SerializeField]
		protected TooltipManager TooltipManager { get; set; }

		public virtual void SendCommand(string command, string format = "")
		{
			if (string.IsNullOrEmpty(format))
			{
				format = DefaultFormat;
			}
			if (string.IsNullOrEmpty(format))
			{
				format = "{0} {1} {2}";
			}
			string text = BuildCommand(command, format);
			if (!string.IsNullOrWhiteSpace(text))
			{
				RemoteAdminClient.SendQuery(text.Trim());
			}
		}

		protected virtual string BuildCommand(string command, string format)
		{
			StringBuilder builder = new StringBuilder();
			string selectedPlayers = GetSelectedPlayers(builder);
			string selectedOptions = GetSelectedOptions(builder);
			string inputFieldText = GetInputFieldText();
			try
			{
				return string.Format(format, command, selectedPlayers, selectedOptions, inputFieldText);
			}
			catch (FormatException)
			{
				return command + " " + selectedPlayers + " " + selectedOptions + inputFieldText;
			}
		}

		protected virtual string GetSelectedPlayers(StringBuilder builder)
		{
			builder.Clear();
			foreach (PlayerRecord instance in PlayerRecord.Instances)
			{
				if (instance != null && instance.IsSelected)
				{
					builder.Append(instance.PlayerId).Append('.');
				}
			}
			string result = builder.ToString();
			builder.Clear();
			return result;
		}

		protected virtual string GetSelectedOptions(StringBuilder builder)
		{
			builder.Clear();
			if (Options != null)
			{
				foreach (ValueButton item in Options.Where((ValueButton x) => x != null).OrderBy((ValueButton x) => x.ChoiceId))
				{
					if (item.IsSelected && item.gameObject.activeInHierarchy)
					{
						builder.Append(item.Value);
					}
				}
			}
			string result = builder.ToString();
			builder.Clear();
			return result;
		}

		protected virtual string GetInputFieldText()
		{
			if (InputFieldText == null || !InputFieldText.gameObject.activeInHierarchy)
			{
				return string.Empty;
			}
			return InputFieldText.text ?? string.Empty;
		}

		protected virtual void OnStart()
		{
		}

		protected virtual void OnUpdate()
		{
		}

		private void Update()
		{
			OnUpdate();
		}

		private void Start()
		{
			if (Options == null)
			{
				Options = new List<ValueButton>();
			}
			foreach (ValueButton option in Options)
			{
				if (option != null && option.CommandMenu == null)
				{
					option.CommandMenu = this;
				}
			}
			OnStart();
		}
	}
}