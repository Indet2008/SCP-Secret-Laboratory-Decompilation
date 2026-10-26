using InventorySystem.Items.Thirdperson;
using InventorySystem.Searching;
using Mirror;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.OverlayAnims
{
	public class SearchCompleteAnimation : OverlayAnimationsBase
	{
		private bool _interacted;

		private double? _startTime;

		private SearchCoordinator _lastSearchCoordinator;

		private const float ClipLength = 1.111f;

		public override bool WantsToPlay
		{
			get
			{
				if (_interacted)
				{
					if (_startTime.HasValue)
					{
						return NetworkTime.time - _startTime.Value < 1.1109999418258667;
					}
					return true;
				}
				return false;
			}
		}

		public override bool Bypassable => true;

		public override AnimationClip Clip => base.Controller.SearchCompleteClip;

		public override float GetLayerWeight(AnimItemLayer3p layer)
		{
			return 1f;
		}

		public override void OnReassigned()
		{
			base.OnReassigned();
			if (NetworkServer.active)
			{
				_lastSearchCoordinator = base.Model.OwnerHub.searchCoordinator;
				_lastSearchCoordinator.OnCompleted += OnSearchCompleted;
			}
		}

		public override void OnStarted()
		{
			base.OnStarted();
			Replay(instant: true);
			_startTime = NetworkTime.time;
		}

		public override void OnStopped()
		{
			base.OnStopped();
			_interacted = false;
			_startTime = null;
		}

		public override void OnReset()
		{
			base.OnReset();
			if (_lastSearchCoordinator != null)
			{
				_lastSearchCoordinator.OnCompleted -= OnSearchCompleted;
			}
		}

		public override void ProcessRpc(NetworkReader reader)
		{
			base.ProcessRpc(reader);
			if (base.IsPlaying)
			{
				Replay(instant: false);
			}
			_interacted = true;
		}

		private void OnSearchCompleted(ISearchCompletor completor)
		{
			if (NetworkServer.active && completor is PickupSearchCompletor)
			{
				SendRpc();
			}
		}
	}
}
