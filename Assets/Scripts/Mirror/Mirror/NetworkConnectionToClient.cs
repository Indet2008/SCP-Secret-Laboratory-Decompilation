namespace Mirror
{
	public class NetworkConnectionToClient : global::Mirror.NetworkConnection
	{
		private readonly global::Mirror.NetworkWriter reliableRpcs = new global::Mirror.NetworkWriter();

		private readonly global::Mirror.NetworkWriter unreliableRpcs = new global::Mirror.NetworkWriter();

		public string IpOverride;

		public readonly global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity> observing = new global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity>();

		public global::Mirror.Unbatcher unbatcher = new global::Mirror.Unbatcher();

		private global::Mirror.ExponentialMovingAverage driftEma;

		private global::Mirror.ExponentialMovingAverage deliveryTimeEma;

		public double remoteTimeline;

		public double remoteTimescale;

		private double bufferTimeMultiplier = 2.0;

		private readonly global::System.Collections.Generic.SortedList<double, global::Mirror.TimeSnapshot> snapshots = new global::System.Collections.Generic.SortedList<double, global::Mirror.TimeSnapshot>();

		public int snapshotBufferSizeLimit = 64;

		private double lastPingTime;

		internal global::Mirror.ExponentialMovingAverage _rtt = new global::Mirror.ExponentialMovingAverage(global::Mirror.NetworkTime.PingWindowSize);

		public virtual string address => IpOverride ?? OriginalIpAddress;

		public string OriginalIpAddress => global::Mirror.Transport.active.ServerGetClientAddress(connectionId);

		[global::System.Obsolete(".clientOwnedObjects was renamed to .owned :)")]
		public global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity> clientOwnedObjects => owned;

		private double bufferTime => (double)global::Mirror.NetworkServer.sendInterval * bufferTimeMultiplier;

		public double rtt => _rtt.Value;

		public NetworkConnectionToClient(int networkConnectionId)
			: base(networkConnectionId)
		{
			driftEma = new global::Mirror.ExponentialMovingAverage(global::Mirror.NetworkServer.sendRate * global::Mirror.NetworkClient.snapshotSettings.driftEmaDuration);
			deliveryTimeEma = new global::Mirror.ExponentialMovingAverage(global::Mirror.NetworkServer.sendRate * global::Mirror.NetworkClient.snapshotSettings.deliveryTimeEmaDuration);
			snapshotBufferSizeLimit = global::UnityEngine.Mathf.Max((int)global::Mirror.NetworkClient.snapshotSettings.bufferTimeMultiplier, snapshotBufferSizeLimit);
		}

		public void OnTimeSnapshot(global::Mirror.TimeSnapshot snapshot)
		{
			if (snapshots.Count < snapshotBufferSizeLimit)
			{
				if (global::Mirror.NetworkClient.snapshotSettings.dynamicAdjustment)
				{
					bufferTimeMultiplier = global::Mirror.SnapshotInterpolation.DynamicAdjustment(global::Mirror.NetworkServer.sendInterval, deliveryTimeEma.StandardDeviation, global::Mirror.NetworkClient.snapshotSettings.dynamicAdjustmentTolerance);
				}
				global::Mirror.SnapshotInterpolation.InsertAndAdjust(snapshots, global::Mirror.NetworkClient.snapshotSettings.bufferLimit, snapshot, ref remoteTimeline, ref remoteTimescale, global::Mirror.NetworkServer.sendInterval, bufferTime, global::Mirror.NetworkClient.snapshotSettings.catchupSpeed, global::Mirror.NetworkClient.snapshotSettings.slowdownSpeed, ref driftEma, global::Mirror.NetworkClient.snapshotSettings.catchupNegativeThreshold, global::Mirror.NetworkClient.snapshotSettings.catchupPositiveThreshold, ref deliveryTimeEma);
			}
		}

		public void UpdateTimeInterpolation()
		{
			if (snapshots.Count > 0)
			{
				global::Mirror.SnapshotInterpolation.StepTime(global::UnityEngine.Time.unscaledDeltaTime, ref remoteTimeline, remoteTimescale);
				global::Mirror.SnapshotInterpolation.StepInterpolation(snapshots, remoteTimeline, out var _, out var _, out var _);
			}
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		protected override void SendToTransport(global::System.ArraySegment<byte> segment, int channelId = 0)
		{
			global::Mirror.Transport.active.ServerSend(connectionId, segment, channelId);
		}

		protected virtual void UpdatePing()
		{
			if (global::Mirror.NetworkTime.localTime >= lastPingTime + (double)global::Mirror.NetworkTime.PingInterval)
			{
				global::Mirror.NetworkPingMessage message = new global::Mirror.NetworkPingMessage(global::Mirror.NetworkTime.localTime);
				Send(message, 1);
				lastPingTime = global::Mirror.NetworkTime.localTime;
			}
		}

		internal override void Update()
		{
			UpdatePing();
			base.Update();
		}

		public override void Disconnect()
		{
			isReady = false;
			reliableRpcs.Position = 0;
			unreliableRpcs.Position = 0;
			global::Mirror.Transport.active.ServerDisconnect(connectionId);
		}

		internal void AddToObserving(global::Mirror.NetworkIdentity netIdentity)
		{
			observing.Add(netIdentity);
			global::Mirror.NetworkServer.ShowForConnection(netIdentity, this);
		}

		internal void RemoveFromObserving(global::Mirror.NetworkIdentity netIdentity, bool isDestroyed)
		{
			observing.Remove(netIdentity);
			if (!isDestroyed)
			{
				global::Mirror.NetworkServer.HideForConnection(netIdentity, this);
			}
		}

		internal void RemoveFromObservingsObservers()
		{
			foreach (global::Mirror.NetworkIdentity item in observing)
			{
				item.RemoveObserver(this);
			}
			observing.Clear();
		}

		internal void AddOwnedObject(global::Mirror.NetworkIdentity obj)
		{
			owned.Add(obj);
		}

		internal void RemoveOwnedObject(global::Mirror.NetworkIdentity obj)
		{
			owned.Remove(obj);
		}

		internal void DestroyOwnedObjects()
		{
			foreach (global::Mirror.NetworkIdentity item in new global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity>(owned))
			{
				if (item != null)
				{
					if (item.sceneId != 0L)
					{
						global::Mirror.NetworkServer.UnSpawn(item.gameObject);
					}
					else
					{
						global::Mirror.NetworkServer.Destroy(item.gameObject);
					}
				}
			}
			owned.Clear();
		}
	}
}
