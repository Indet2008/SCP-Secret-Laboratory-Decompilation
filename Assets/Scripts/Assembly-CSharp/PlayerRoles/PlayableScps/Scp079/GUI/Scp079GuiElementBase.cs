using AudioPooling;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079GuiElementBase : MonoBehaviour
	{
		protected Scp079Role Role { get; private set; }

		protected ReferenceHub Owner { get; private set; }

		internal virtual void Init(Scp079Role role, ReferenceHub owner)
		{
			Role = role;
			Owner = owner;
		}

		protected PooledAudioSource PlaySound(AudioClip clip, float pitch = 1f)
		{
			return AudioSourcePoolManager.Play2DWithParent(clip, MainCameraController.CurrentCamera, 1f, MixerChannel.DefaultSfx, pitch);
		}
	}
}
