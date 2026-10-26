using Mirror;
using RelativePositioning;
using UnityEngine;

namespace Hazards
{
	[RequireComponent(typeof(TransformWaypointFollower))]
	public abstract class TemporaryHazard : EnvironmentalHazard
	{
		public float Elapsed;

		private bool _active;

		private bool _destroyed;

		public override bool IsActive
		{
			get
			{
				if (!_destroyed)
				{
					return _active;
				}
				return false;
			}
			set
			{
				_active = value;
			}
		}

		public abstract float HazardDuration { get; set; }

		public virtual float DecaySpeed { get; set; } = 1f;

		[Server]
		public virtual void ServerDestroy()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void Hazards.TemporaryHazard::ServerDestroy()' called when server was not active");
				return;
			}
			_destroyed = true;
			IsActive = false;
			for (int num = base.AffectedPlayers.Count - 1; num >= 0; num--)
			{
				OnExit(base.AffectedPlayers[num]);
			}
		}

		protected override void Start()
		{
			base.Start();
			IsActive = true;
		}

		protected override void Update()
		{
			base.Update();
			if (NetworkServer.active && IsActive)
			{
				if (Elapsed > HazardDuration)
				{
					ServerDestroy();
				}
				else
				{
					Elapsed += DecaySpeed * Time.deltaTime;
				}
			}
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
