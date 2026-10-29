using Interactables;
using Mirror;
using PlayerStatsSystem;
using PlayerRoles;
using PlayerRoles.Ragdolls;
using TMPro;
using UnityEngine;

public class RagdollInspector : MonoBehaviour
{
	[SerializeField]
	private LayerMask _raycastMask;

	[SerializeField]
	private float _raycastDistance;

	[SerializeField]
	private TextMeshProUGUI _ragdollInspectText;

	private bool _isVisible;

	public static string DefaultFormat => TranslationReader.Get("DeathReasons", 0, "It's <b>{0}</b>'s body - they were {1}!\n\nCause of death: {2}");

	private void OnEnable()
	{
		CenterScreenRaycast.OnCenterRaycastHit += OnRaycastHit;
		CenterScreenRaycast.OnCenterRaycastMissed += Hide;
	}

	private void OnDisable()
	{
		CenterScreenRaycast.OnCenterRaycastHit -= OnRaycastHit;
		CenterScreenRaycast.OnCenterRaycastMissed -= Hide;
	}

	private void OnRaycastHit(RaycastHit hit)
	{
		if (TryGetRagdoll(hit, out var ragdoll, out var role))
		{
			Show(ragdoll, role);
		}
		else
		{
			Hide();
		}
	}

	private void Show(BasicRagdoll ragdoll, PlayerRoleBase role)
	{
		DamageHandlerBase handler = GetClientHandler(ragdoll);
		string format = GetFormatOverride(role) ?? GetFormatOverride(ragdoll) ?? GetFormatOverride(handler) ?? DefaultFormat;
		_ragdollInspectText.text = string.Format(format, ragdoll.Info.Nickname, role.GetColoredName(), handler.RagdollInspectText);
		_isVisible = true;
	}

	private BasicRagdoll _cachedRagdoll;

	private DamageHandlerBase _cachedHandler;

	// On a listen-server host the ragdoll holds the server-side handler, whose inspect text is only
	// filled in ReadAdditionalData on clients. Round-trip it through the network serializer like a remote client would.
	private DamageHandlerBase GetClientHandler(BasicRagdoll ragdoll)
	{
		DamageHandlerBase handler = ragdoll.Info.Handler;
		if (!NetworkServer.active || handler == null)
		{
			return handler;
		}
		if (_cachedRagdoll == ragdoll && _cachedHandler != null)
		{
			return _cachedHandler;
		}
		try
		{
			using NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteDamageHandler(handler);
			using NetworkReaderPooled reader = NetworkReaderPool.Get(writer.ToArraySegment());
			_cachedHandler = reader.ReadDamageHandler() ?? handler;
		}
		catch (System.Exception ex)
		{
			Debug.LogException(ex);
			_cachedHandler = handler;
		}
		_cachedRagdoll = ragdoll;
		return _cachedHandler;
	}

	private void Hide()
	{
		if (_isVisible)
		{
			_isVisible = false;
			_ragdollInspectText.text = string.Empty;
		}
	}

	private bool TryGetRagdoll(RaycastHit hit, out BasicRagdoll ragdoll, out PlayerRoleBase role)
	{
		ragdoll = null;
		role = null;
		if (hit.distance > _raycastDistance)
		{
			return false;
		}
		if (ReferenceHub.TryGetLocalHub(out var hub) && hub.GetTeam() == Team.Dead)
		{
			return false;
		}
		if (hit.collider == null)
		{
			return false;
		}
		for (Transform t = hit.collider.transform; t != null; t = t.parent)
		{
			if (t.TryGetComponent<BasicRagdoll>(out ragdoll))
			{
				return PlayerRoleLoader.TryGetRoleTemplate<PlayerRoleBase>(ragdoll.Info.RoleType, out role);
			}
		}
		return false;
	}

	private string GetFormatOverride<T>(T obj)
	{
		if (obj is IRagdollInspectOverride ragdollInspectOverride)
		{
			return ragdollInspectOverride.RagdollInspectFormatOverride;
		}
		return null;
	}
}
