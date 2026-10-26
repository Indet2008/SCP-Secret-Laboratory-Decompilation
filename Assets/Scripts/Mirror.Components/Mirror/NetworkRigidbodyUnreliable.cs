namespace Mirror
{
	public class NetworkRigidbodyUnreliable : global::Mirror.NetworkTransformUnreliable
	{
		private global::UnityEngine.Rigidbody rb;

		private bool wasKinematic;

		private new bool clientAuthority => syncDirection == global::Mirror.SyncDirection.ClientToServer;

		protected override void Awake()
		{
			rb = target.GetComponent<global::UnityEngine.Rigidbody>();
			if (rb == null)
			{
				global::UnityEngine.Debug.LogError(base.name + "'s NetworkRigidbody.target " + target.name + " is missing a Rigidbody", this);
				return;
			}
			wasKinematic = rb.isKinematic;
			base.Awake();
		}

		public override void OnStopServer()
		{
			rb.isKinematic = wasKinematic;
		}

		public override void OnStopClient()
		{
			rb.isKinematic = wasKinematic;
		}

		private void FixedUpdate()
		{
			if (base.isServer && base.isClient)
			{
				if (clientAuthority && !base.IsClientWithAuthority)
				{
					rb.isKinematic = true;
				}
			}
			else if (base.isClient)
			{
				if (!base.IsClientWithAuthority)
				{
					rb.isKinematic = true;
				}
			}
			else if (base.isServer && clientAuthority)
			{
				rb.isKinematic = true;
			}
		}

		protected override void OnValidate()
		{
			base.OnValidate();
			if (target.GetComponent<global::UnityEngine.Rigidbody>() == null)
			{
				global::UnityEngine.Debug.LogWarning(base.name + "'s NetworkRigidbody.target " + target.name + " is missing a Rigidbody", this);
			}
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
