namespace LabApi.Features.Wrappers
{
	public class Workstation : global::LabApi.Features.Wrappers.Structure
	{
		public new static global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.SpawnableStructure, global::LabApi.Features.Wrappers.Workstation> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.SpawnableStructure, global::LabApi.Features.Wrappers.Workstation>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Workstation> List => Dictionary.Values;

		public global::InventorySystem.Items.Firearms.Attachments.WorkstationController BaseController { get; }

		public global::InventorySystem.Items.Firearms.Attachments.WorkstationController.WorkstationStatus Status
		{
			get
			{
				return (global::InventorySystem.Items.Firearms.Attachments.WorkstationController.WorkstationStatus)BaseController.Status;
			}
			set
			{
				BaseController.NetworkStatus = (byte)value;
			}
		}

		public global::System.Diagnostics.Stopwatch Stopwatch => BaseController.ServerStopwatch;

		public global::LabApi.Features.Wrappers.Player KnownUser
		{
			get
			{
				return global::LabApi.Features.Wrappers.Player.Get(BaseController.KnownUser);
			}
			set
			{
				BaseController.KnownUser = value.ReferenceHub;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("spawnableStructure")]
		public new static global::LabApi.Features.Wrappers.Workstation? Get(global::MapGeneration.Distributors.SpawnableStructure? spawnableStructure)
		{
			if (spawnableStructure == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(spawnableStructure, out global::LabApi.Features.Wrappers.Workstation value))
			{
				return (global::LabApi.Features.Wrappers.Workstation)global::LabApi.Features.Wrappers.Structure.CreateStructureWrapper(spawnableStructure);
			}
			return value;
		}

		internal Workstation(global::MapGeneration.Distributors.SpawnableStructure spawnableStructure)
			: base(spawnableStructure)
		{
			BaseController = spawnableStructure.GetComponent<global::InventorySystem.Items.Firearms.Attachments.WorkstationController>();
			if (base.CanCache)
			{
				Dictionary.Add(spawnableStructure, this);
			}
		}

		public bool IsInRange(global::LabApi.Features.Wrappers.Player player)
		{
			return BaseController.IsInRange(player.ReferenceHub);
		}

		public void Interact(global::LabApi.Features.Wrappers.Player player)
		{
			BaseController.ServerInteract(player.ReferenceHub, BaseController.ActivateCollider.ColliderId);
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(base.Base);
		}
	}
}
