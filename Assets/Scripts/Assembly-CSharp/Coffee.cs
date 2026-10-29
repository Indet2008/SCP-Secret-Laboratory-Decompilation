using System.Collections.Generic;
using System.Runtime.InteropServices;
using Hints;
using Interactables;
using Interactables.Verification;
using InventorySystem.Items.Usables;
using MapGeneration;
using Mirror;
using PlayerRoles;
using UnityEngine;

public class Coffee : NetworkBehaviour, IClientInteractable, IInteractable, IServerInteractable
{
	private const float DurationPerCharacter = 0.035f;

	private const float MaxDuration = 7f;

	private const float MinDuration = 4f;

	private const float TotalRegenerationTime = 15f;

	private const int TotalHpToRegenerate = 50;

	private static readonly HashSet<ReferenceHub> BlacklistedPlayers = new HashSet<ReferenceHub>();

	[SyncVar(hook = "SyncCoffeeState")]
	public bool IsConsumed;

	[SerializeField]
	private Color _drinkColor;

	[SerializeField]
	private CoffeeTranslation _drinkText;

	[SerializeField]
	private string _author;

	[SerializeField]
	private MeshRenderer _meshRenderer;

	[SerializeField]
	private AnimationCurve _healProgress;

	[SerializeField]
	private Animator _animator;

	[SerializeField]
	private ParticleSystem _particles;

	[SerializeField]
	private AudioSource _audioSource;

	public IVerificationRule VerificationRule { get; } = StandardDistanceVerification.Default;

	public bool NetworkIsConsumed
	{
		get
		{
			return IsConsumed;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref IsConsumed, 1uL, SyncCoffeeState);
		}
	}

	private void Awake()
	{
		if (IsConsumed)
		{
			_animator.enabled = true;
			_particles.Stop();
		}
	}

	private void Start()
	{
		_meshRenderer.material.color = _drinkColor;
	}

	public void ServerInteract(ReferenceHub ply, byte colliderId)
	{
		if (BlacklistedPlayers.Add(ply))
		{
			UsableItemsController.GetHandler(ply).ActiveRegenerations.Add(new RegenerationProcess(_healProgress, 1f / 15f, 50f));
			NetworkIsConsumed = true;
		}
	}

	public void ClientInteract(InteractableCollider collider)
	{
		bool flag = Translations.TryGet(CoffeeTranslation.EnoughCoffee, out string tr);
		if (!IsConsumed)
		{
			bool flag2 = Translations.TryGet(_drinkText, out string tr2);
			ReferenceHub localHub = ReferenceHub.LocalHub;
			bool flag3 = BlacklistedPlayers.Contains(localHub);
			if (flag && flag2)
			{
				ShowMessage(tr, tr2, flag3);
			}
			if (!flag3)
			{
				BlacklistedPlayers.Add(localHub);
			}
		}
	}

	private void ShowMessage(string enoughCoffee, string drinkText, bool blacklisted)
	{
		if (ReferenceHub.TryGetLocalHub(out var hub))
		{
			string text;
			if (blacklisted)
			{
				text = "\n\n\n\n" + enoughCoffee;
			}
			else
			{
				text = "\n\n\n\n" + drinkText;
				if (_author.Length > 0)
				{
					text = text + "\n\n<i>— " + _author + "</i>";
				}
			}
			float durationScalar = Mathf.Clamp((float)text.Length * 0.035f, 4f, 7f);
			hub.hints.Show(new TextHint(text, new HintParameter[1]
			{
				new StringHintParameter(text)
			}, null, durationScalar));
		}
	}

	private void SyncCoffeeState(bool wasConsumed, bool isConsumed)
	{
		_animator.enabled = isConsumed;
		if (isConsumed)
		{
			_particles.Stop();
			_audioSource.Play();
		}
		else
		{
			_particles.Play();
		}
	}

	[RuntimeInitializeOnLoadMethod]
	private static void Init()
	{
		PlayerRoleManager.OnRoleChanged += (ReferenceHub hub, PlayerRoleBase _, PlayerRoleBase _) =>
		{
			BlacklistedPlayers.Remove(hub);
		};
		ReferenceHub.OnPlayerRemoved += (ReferenceHub hub) =>
		{
			BlacklistedPlayers.Remove(hub);
		};
		SeedSynchronizer.OnGenerationFinished += () =>
		{
			BlacklistedPlayers.Clear();
		};
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
			writer.WriteBool(IsConsumed);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteBool(IsConsumed);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref IsConsumed, SyncCoffeeState, reader.ReadBool());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref IsConsumed, SyncCoffeeState, reader.ReadBool());
		}
	}
}
