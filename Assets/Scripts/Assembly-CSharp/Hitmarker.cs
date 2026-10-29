using AudioPooling;
using CustomPlayerEffects;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.Spectating;
using PlayerStatsSystem;
using UnityEngine;

public class Hitmarker : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	[global::UnityEngine.SerializeField]
	private global::UnityEngine.AnimationCurve _sizeOverTime;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.AnimationCurve _opacityOverTime;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.CanvasRenderer _targetImage;

	[global::UnityEngine.SerializeField]
	private float _animationTime;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.Texture2D _hitmarkerTexture;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.Texture2D _antiHitmarkerTexture;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.UI.RawImage _hitmarkerImage;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.AudioClip[] _hitmarkerSounds;

	[global::UnityEngine.SerializeField]
	private global::UnityEngine.AudioClip[] _antiHitmarkerSounds;

	private float _timer;

	private float _targetSize;

	private static Hitmarker _singleton;


	public struct HitmarkerMessage : NetworkMessage
	{
		public byte Size;

		public bool Audio;

		public HitmarkerType Hitmarker;

		public HitmarkerMessage(byte size, bool playAudio = true, HitmarkerType hitmarkerType = HitmarkerType.Regular)
		{
			Size = size;
			Audio = playAudio;
			Hitmarker = hitmarkerType;
		}
	}

	private const float MaxSize = 2.55f;

	[RuntimeInitializeOnLoadMethod]
	private static void Init()
	{
		CustomNetworkManager.OnClientReady += () =>
		{
			NetworkClient.ReplaceHandler<HitmarkerMessage>(HitmarkerMsgReceived);
		};
	}

	private static void HitmarkerMsgReceived(HitmarkerMessage msg)
	{
		PlayHitmarker((float)(int)msg.Size / 255f * 2.55f, msg.Audio, msg.Hitmarker);
	}

	private void Awake()
	{
		_singleton = this;
	}

	private void Update()
	{
		if (!(_timer > _animationTime))
		{
			_timer += Time.deltaTime;
			_targetImage.SetAlpha(_opacityOverTime.Evaluate(_timer));
			_targetImage.transform.localScale = Vector3.one * (_targetSize * _sizeOverTime.Evaluate(_timer));
		}
	}

	public static void PlayHitmarker(float size, bool playAudio = true, HitmarkerType hitmarkerType = HitmarkerType.Regular)
	{
		if (hitmarkerType != HitmarkerType.None)
		{
			_singleton._targetSize = size;
			_singleton._timer = 0f;
			_singleton._hitmarkerImage.texture = ((hitmarkerType == HitmarkerType.Blocked) ? _singleton._antiHitmarkerTexture : _singleton._hitmarkerTexture);
			if (playAudio)
			{
				AudioSourcePoolManager.Play2D(((hitmarkerType == HitmarkerType.Blocked) ? _singleton._antiHitmarkerSounds : _singleton._hitmarkerSounds).RandomItem(), 1f, MixerChannel.NoDucking);
			}
		}
	}

	public static void SendHitmarkerDirectly(ReferenceHub hub, float size, bool playAudio = true, HitmarkerType hitmarkerType = HitmarkerType.Regular)
	{
		if (hub == null)
		{
			return;
		}
		size = Mathf.Clamp(size, 0f, 2.55f);
		if (hub.isLocalPlayer)
		{
			PlayHitmarker(size, playAudio, hitmarkerType);
			return;
		}
		PlayerSendingHitmarkerEventArgs e = new PlayerSendingHitmarkerEventArgs(hub, size, playAudio, hitmarkerType);
		PlayerEvents.OnSendingHitmarker(e);
		if (e.IsAllowed)
		{
			size = e.Size;
			playAudio = e.PlayAudio;
			hub = e.Player.ReferenceHub;
			hitmarkerType = e.Hitmarker;
			new HitmarkerMessage((byte)Mathf.RoundToInt(size / 2.55f * 255f), playAudio, hitmarkerType).SendToSpectatorsOf(hub, includeTarget: true);
			PlayerEvents.OnSentHitmarker(new PlayerSentHitmarkerEventArgs(hub, size, playAudio, hitmarkerType));
		}
	}

	public static void SendHitmarkerDirectly(NetworkConnection conn, float size)
	{
		if (ReferenceHub.TryGetHub(conn, out var hub))
		{
			SendHitmarkerDirectly(hub, size);
		}
	}

	public static void SendHitmarkerConditionally(float size, AttackerDamageHandler adh, ReferenceHub victim)
	{
		if (CheckHitmarkerPerms(adh, victim))
		{
			SendHitmarkerDirectly(adh.Attacker.Hub, size);
		}
	}

	public static bool CheckHitmarkerPerms(AttackerDamageHandler adh, ReferenceHub victim)
	{
		if (victim.roleManager.CurrentRole is IHitmarkerPreventer hitmarkerPreventer && hitmarkerPreventer.TryPreventHitmarker(adh))
		{
			PlayerEvents.OnCheckedHitmarker(new PlayerCheckedHitmarkerEventArgs(adh.Attacker.Hub, adh, victim, result: false));
			return false;
		}
		PlayerEffectsController playerEffectsController = victim.playerEffectsController;
		for (int i = 0; i < playerEffectsController.EffectsLength; i++)
		{
			StatusEffectBase statusEffectBase = playerEffectsController.AllEffects[i];
			if (statusEffectBase is IHitmarkerPreventer hitmarkerPreventer2 && statusEffectBase.IsEnabled && hitmarkerPreventer2.TryPreventHitmarker(adh))
			{
				PlayerEvents.OnCheckedHitmarker(new PlayerCheckedHitmarkerEventArgs(adh.Attacker.Hub, adh, victim, result: false));
				return false;
			}
		}
		PlayerEvents.OnCheckedHitmarker(new PlayerCheckedHitmarkerEventArgs(adh.Attacker.Hub, adh, victim, result: true));
		return true;
	}
}
