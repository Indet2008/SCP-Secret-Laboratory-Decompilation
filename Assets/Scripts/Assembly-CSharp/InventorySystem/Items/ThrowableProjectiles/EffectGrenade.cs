using Mirror;
using UnityEngine;
using Utils;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class EffectGrenade : TimeGrenade
	{
		public GameObject Effect;

		[SerializeField]
		private float _destroyTime;

		[SerializeField]
		private AudioSource _src;

		private bool _resyncAudio = true;

		public override void ToggleRenderers(bool state)
		{
			base.ToggleRenderers(state);
			_resyncAudio = state;
		}

		protected override void Update()
		{
			base.Update();
			double time = NetworkTime.time;
			if (!_resyncAudio || base.TargetTime < time)
			{
				return;
			}
			_resyncAudio = false;
			if (!(_src == null))
			{
				float length = _src.clip.length;
				float num = (float)(base.TargetTime - time);
				if (num > length)
				{
					_src.PlayDelayed(num - length);
					return;
				}
				_src.Play();
				_src.time = length - num;
			}
		}

		public virtual void PlayExplosionEffects(Vector3 position)
		{
			Transform obj = Object.Instantiate(Effect).transform;
			obj.position = position;
			obj.localScale = Vector3.one;
			Object.Destroy(obj.gameObject, _destroyTime);
		}

		public override bool ServerFuseEnd()
		{
			if (!base.ServerFuseEnd())
			{
				return false;
			}
			ExplosionUtils.ServerSpawnEffect(base.transform.position, Info.ItemId);
			DestroySelf();
			return true;
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
