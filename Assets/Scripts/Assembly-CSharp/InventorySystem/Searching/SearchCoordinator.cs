using System;
using System.Runtime.InteropServices;
using CursorManagement;
using Mirror;
using Mirror.LiteNetLib4Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using UnityEngine;
using UserSettings;
using UserSettings.ControlsSettings;

namespace InventorySystem.Searching
{
	[RequireComponent(typeof(ReferenceHub))]
	public class SearchCoordinator : NetworkBehaviour, ICursorOverride
	{
		public const string DebugKey = "SEARCH";

		[Header("Network Shared")]
		[SerializeField]
		[SyncVar(hook = "SetRayDistance")]
		private float rayDistance = 3f;

		[Header("Server only")]
		[SerializeField]
		private float serverRayDistanceThreshold = 1.2f;

		[SerializeField]
		private double serverDelayThreshold = 1.399999976158142;

		private static readonly CachedUserSetting<bool> ToggleSearch = new CachedUserSetting<bool>(MiscControlsSetting.SearchToggle);

		public ReferenceHub Hub { get; private set; }

		public CursorOverrideMode CursorOverride => CursorOverrideMode.NoOverride;

		public bool LockMovement => SessionPipe.Status != SearchSessionPipe.Activity.Idle;

		public float ServerMaxRayDistanceSqr { get; private set; }

		public float RayDistance
		{
			get
			{
				return rayDistance;
			}
			set
			{
				if (!NetworkServer.active)
				{
					throw new InvalidOperationException("The ray distance can only be set by the server.");
				}
				NetworkrayDistance = value;
				UpdateMaxDistanceSqr();
			}
		}

		public SearchSessionPipe SessionPipe { get; private set; }

		public ISearchCompletor Completor { get; private set; }

		public float NetworkrayDistance
		{
			get
			{
				return rayDistance;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref rayDistance, 1uL, SetRayDistance);
			}
		}

		public event Action<ISearchCompletor> OnCompleted;

		private void SetRayDistance(float oldValue, float newValue)
		{
			UpdateMaxDistanceSqr();
		}

		private void UpdateMaxDistanceSqr()
		{
			ServerMaxRayDistanceSqr = rayDistance * rayDistance * serverRayDistanceThreshold;
		}

		private void Start()
		{
			UpdateMaxDistanceSqr();
			Hub = ReferenceHub.GetHub(base.gameObject);
			SessionPipe = new SearchSessionPipe(this, NetworkServer.active ? Hub.playerRateLimitHandler.RateLimits[0] : null);
			SessionPipe.RequestUpdated += HandleRequest;
			SessionPipe.SessionUpdated += HandleSession;
			SessionPipe.RegisterHandlers();
			PlayerRoleManager.OnRoleChanged += RoleChanged;
		}

		private void OnDestroy()
		{
			if (Hub != null && Hub.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				fpcRole.FpcModule.Motor.UnregisterMovementLock(this);
			}
			PlayerRoleManager.OnRoleChanged -= RoleChanged;
		}

		private readonly struct ProgressBezier
		{
			private readonly SearchRequest _request;

			private readonly SearchSession _session;

			private readonly double _requestProgress;

			private readonly double _sessionReceivedTime;

			public double Progress
			{
				get
				{
					double num = (NetworkTime.time - _sessionReceivedTime) / (_session.FinishTime - _sessionReceivedTime);
					double num2 = 1.0 - num;
					return num2 * num2 * _requestProgress + 2.0 * num2 * num + num * num;
				}
			}

			public ProgressBezier(SearchRequest request, SearchSession session)
			{
				_request = request;
				_session = session;
				_requestProgress = request.Body.Progress;
				_sessionReceivedTime = NetworkTime.time;
			}
		}

		private ProgressBezier _progressBezier;

		private byte _ticketId;

		private bool _isSearching;

		private double _sessionReceivedTime;

		private double _requestProgressAtPromise;

		private ISearchCompletor _clientCompletor;

		private static readonly CachedLayerMask PickupMask = new CachedLayerMask("Pickup");

		private void Update()
		{
			if (base.isLocalPlayer && SessionPipe != null)
			{
				ContinuePickupClient();
			}
			if (NetworkServer.active && SessionPipe.Status == SearchSessionPipe.Activity.Promised)
			{
				ContinuePickupServer();
			}
			SessionPipe.Update();
		}

		private void HandleRequest()
		{
			bool flag;
			SearchSession? session;
			ISearchCompletor completor;
			try
			{
				flag = ReceiveRequestUnsafe(out session, out completor);
			}
			catch (Exception exception)
			{
				SessionPipe.Invalidate();
				DebugLog.LogException(exception);
				return;
			}
			if (flag)
			{
				if (session.HasValue)
				{
					SessionPipe.Session = session.Value;
				}
				else
				{
					SessionPipe.Invalidate();
				}
			}
			Completor = completor;
		}

		private bool ReceiveRequestUnsafe(out SearchSession? session, out ISearchCompletor completor)
		{
			SearchRequest request = SessionPipe.Request;
			completor = request.Target.GetSearchCompletor(this, ServerMaxRayDistanceSqr);
			if (completor == null || !completor.ValidateStart())
			{
				session = null;
				completor = null;
				return true;
			}
			SearchSession body = request.Body;
			if (!base.isLocalPlayer)
			{
				double num = NetworkTime.time - request.InitialTime;
				double num2 = (double)LiteNetLib4MirrorServer.Peers[base.connectionToClient.connectionId].Ping * 0.001 * serverDelayThreshold;
				float num3 = request.Target.SearchTimeForPlayer(Hub);
				if (num < 0.0 || num2 < num)
				{
					body.InitialTime = NetworkTime.time - num2;
					body.FinishTime = body.InitialTime + (double)num3;
				}
				else if (Math.Abs(body.FinishTime - body.InitialTime - (double)num3) > 0.001)
				{
					body.FinishTime = body.InitialTime + (double)num3;
				}
			}
			session = body;
			return true;
		}

		private void ContinuePickupServer()
		{
			if (Completor.ValidateUpdate())
			{
				if (!(NetworkTime.time < SessionPipe.Session.FinishTime))
				{
					Completor.Complete();
					OnCompleted?.Invoke(Completor);
				}
			}
			else
			{
				SessionPipe.Invalidate();
			}
		}

		private void SetSearching(bool state)
		{
			if (_isSearching != state)
			{
				_isSearching = state;
				UserMainInterface singleton = UserMainInterface.singleton;
				if (singleton != null && singleton.searchObject != null)
				{
					singleton.searchObject.SetActive(state);
				}
				if (singleton != null && singleton.searchRadial != null)
				{
					singleton.searchRadial.fillAmount = 0f;
				}
			}
		}

		private void HandleSession()
		{
			_progressBezier = new ProgressBezier(SessionPipe.Request, SessionPipe.Session);
			_sessionReceivedTime = NetworkTime.time;
			_requestProgressAtPromise = SessionPipe.Request.Progress;
		}

		private void ContinuePickupClient()
		{
			if (SessionPipe.Status == SearchSessionPipe.Activity.Idle)
			{
				_sessionReceivedTime = 0.0;
				_requestProgressAtPromise = 0.0;
				SetSearching(state: false);
				Raycast();
				return;
			}
			KeyCode key = NewInput.GetKey(ActionName.Interact);
			bool flag = (ToggleSearch.Value ? Input.GetKeyDown(key) : (!Input.GetKey(key)));
			if (flag || (_clientCompletor != null && !_clientCompletor.ValidateUpdate()))
			{
				SessionPipe.ClientAbort();
				SetSearching(state: false);
				return;
			}
			double num;
			if (SessionPipe.Status == SearchSessionPipe.Activity.Promised)
			{
				// On a host the session-received callback may never fire; fall back to the session's own start.
				bool flag2 = _sessionReceivedTime > 0.0 && _sessionReceivedTime >= SessionPipe.Session.InitialTime;
				double num2 = (flag2 ? _sessionReceivedTime : SessionPipe.Session.InitialTime);
				double num3 = (flag2 ? _requestProgressAtPromise : 0.0);
				double num4 = SessionPipe.Session.FinishTime - num2;
				double t = ((num4 > 0.0) ? ((NetworkTime.time - num2) / num4) : 0.0);
				num = (flag2 ? _progressBezier.Progress : (num3 + (1.0 - num3) * Math.Max(0.0, Math.Min(1.0, t))));
			}
			else
			{
				num = SessionPipe.Request.Progress;
			}
			SetSearching(num < 1.0);
			UserMainInterface singleton = UserMainInterface.singleton;
			if (singleton != null && singleton.searchRadial != null)
			{
				singleton.searchRadial.fillAmount = Mathf.Clamp01((float)num);
			}
		}

		private void Raycast()
		{
			KeyCode key = NewInput.GetKey(ActionName.Interact);
			if (!Input.GetKeyDown(key) || Cursor.visible || !(Hub.roleManager.CurrentRole is IFpcRole))
			{
				return;
			}
			Transform playerCameraReference = Hub.PlayerCameraReference;
			int layerMask = (int)Interactables.InteractionCoordinator.RaycastMask | (int)PickupMask;
			if (!Physics.Raycast(playerCameraReference.position, playerCameraReference.forward, out var hitInfo, rayDistance, layerMask))
			{
				return;
			}
			ISearchable componentInParent = hitInfo.collider.GetComponentInParent<ISearchable>();
			if (componentInParent == null || !componentInParent.CanSearch || componentInParent.netIdentity == null)
			{
				return;
			}
			ISearchCompletor searchCompletor;
			try
			{
				searchCompletor = componentInParent.GetSearchCompletor(this, rayDistance * rayDistance);
			}
			catch
			{
				return;
			}
			if (searchCompletor != null && searchCompletor.ValidateStart())
			{
				_clientCompletor = searchCompletor;
				float num = componentInParent.SearchTimeForPlayer(Hub);
				SearchSession body = new SearchSession(NetworkTime.time, NetworkTime.time + (double)num, componentInParent);
				SessionPipe.ClientRequest(new SearchRequest(++_ticketId, body));
			}
		}

		private void RoleChanged(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (!(userHub != Hub))
			{
				if (prevRole is IFpcRole fpcRole)
				{
					fpcRole.FpcModule.Motor.UnregisterMovementLock(this);
				}
				if (newRole is IFpcRole fpcRole2)
				{
					fpcRole2.FpcModule.Motor.RegisterMovementLock(this);
				}
			}
		}

		public override bool Weaved()
		{
			return true;
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteFloat(rayDistance);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteFloat(rayDistance);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref rayDistance, SetRayDistance, reader.ReadFloat());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref rayDistance, SetRayDistance, reader.ReadFloat());
			}
		}
	}
}
