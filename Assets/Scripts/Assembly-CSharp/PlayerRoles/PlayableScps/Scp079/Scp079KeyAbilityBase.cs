using System;
using NetworkManagerUtils.Dummies;
using PlayerRoles.PlayableScps.Scp079.GUI;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	public abstract class Scp079KeyAbilityBase : Scp079AbilityBase, IScp079FailMessageProvider
	{
		private enum Category
		{
			Movement = 0,
			SpecialAbility = 1,
			OverconInteraction = 2
		}

		[SerializeField]
		private Category _category;

		private static string _translationNoAux;

		private static UnityEngine.Object TrackedFailMessage
		{
			get
			{
				if (!Scp079AbilityList.TryGetSingleton(out var singleton))
				{
					return null;
				}
				return singleton.TrackedFailMessage as UnityEngine.Object;
			}
			set
			{
				if (Scp079AbilityList.TryGetSingleton(out var singleton))
				{
					singleton.TrackedFailMessage = value as IScp079FailMessageProvider;
				}
			}
		}

		public abstract ActionName ActivationKey { get; }

		public abstract bool IsReady { get; }

		public abstract bool IsVisible { get; }

		public abstract string AbilityName { get; }

		public abstract string FailMessage { get; }

		public virtual bool DummyEmulationSupport => false;

		public int CategoryId => (int)_category;

		[field: SerializeField]
		public bool UseLeftMenu { get; private set; }

		protected string GetNoAuxMessage(float cost)
		{
			return _translationNoAux + "\n" + base.AuxManager.GenerateETA(cost);
		}

		protected virtual void Start()
		{
			_translationNoAux = Translations.Get(Scp079HudTranslation.NotEnoughAux);
		}

		protected virtual void Update()
		{
			if (((!base.Role.IsLocalPlayer || !IsVisible) && !base.Role.IsEmulatedDummy) || !GetActionDown(ActivationKey) || base.LostSignalHandler.Lost || Scp079IntroCutscene.IsPlaying)
			{
				return;
			}
			if (IsReady)
			{
				if (TrackedFailMessage == this)
				{
					TrackedFailMessage = null;
				}
				Trigger();
			}
			else
			{
				TrackedFailMessage = this;
			}
		}

		protected abstract void Trigger();

		public virtual void OnFailMessageAssigned()
		{
		}

		public override void PopulateDummyActions(Action<DummyAction> actionAdder, Action<string> categoryAdder)
		{
			if (DummyEmulationSupport)
			{
				base.PopulateDummyActions(actionAdder, categoryAdder);
			}
		}
	}
}
