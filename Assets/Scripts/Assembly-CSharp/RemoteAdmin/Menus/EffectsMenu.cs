using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using CustomPlayerEffects;
using RemoteAdmin.Elements;
using RemoteAdmin.Interfaces;
using UnityEngine;

namespace RemoteAdmin.Menus
{
	public class EffectsMenu : RaCommandMenu
	{
		private readonly List<RaEffectButton> _effectButtons = new List<RaEffectButton>();

		[SerializeField]
		private RaEffectButton _buttonTemplate;

		[SerializeField]
		private Transform _rootParent;

		private bool _populated;

		public void ResetOptions()
		{
			foreach (RaEffectButton effectButton in _effectButtons)
			{
				if (effectButton != null)
				{
					effectButton.ResetFields();
				}
			}
		}

		protected override void OnStart()
		{
			TryPopulate();
		}

		protected override void OnUpdate()
		{
			if (!_populated)
			{
				TryPopulate();
			}
		}

		private void TryPopulate()
		{
			if (_populated || _buttonTemplate == null || _rootParent == null || !ReferenceHub.TryGetLocalHub(out var hub) || hub.playerEffectsController.AllEffects == null)
			{
				return;
			}
			_populated = true;
			foreach (StatusEffectBase item in hub.playerEffectsController.AllEffects.OrderByDescending((StatusEffectBase x) => x.Classification))
			{
				RaEffectButton raEffectButton = Object.Instantiate(_buttonTemplate, _rootParent);
				raEffectButton.gameObject.SetActive(value: true);
				raEffectButton.CommandMenu = this;
				raEffectButton.EffectId = item.GetType().Name;
				raEffectButton.EffectName = (IsCustomDisplay(item, out var display) ? display.DisplayName : BuildName(item.GetType().Name));
				raEffectButton.Setup();
				_effectButtons.Add(raEffectButton);
			}
		}

		private bool IsCustomDisplay(StatusEffectBase statusEffect, out ICustomDisplayName display)
		{
			display = statusEffect as ICustomDisplayName;
			return display != null;
		}

		private string BuildName(string objectName)
		{
			return Regex.Replace(objectName, "(\\B[A-Z])", " $1");
		}
	}
}