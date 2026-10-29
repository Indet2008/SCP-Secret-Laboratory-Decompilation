using PlayerRoles.PlayableScps.Scp106;
using UnityEngine;

namespace DeathAnimations
{
	public class Scp106Animation : FirstpersonDeathAnimation
	{
		public float delay = 6f;

		public Transform portalAnchor;

		private bool _disable;

		private float _fadeTime;

		private void Update()
		{
			_fadeTime += Time.deltaTime;
			if (!_disable && !(_fadeTime < delay))
			{
				Scp106Hud.SetDissolveAnimation(_fadeTime - delay);
			}
			if (!(delay + 1.5f > _fadeTime))
			{
				Renderer[] componentsInChildren = GetComponentsInChildren<Renderer>();
				for (int i = 0; i < componentsInChildren.Length; i++)
				{
					componentsInChildren[i].gameObject.SetActive(value: false);
				}
				base.enabled = false;
			}
		}

		protected override void OnAnimationStarted()
		{
			base.OnAnimationStarted();
			base.enabled = true;
			Vector3 position = portalAnchor.position;
			if (Physics.Raycast(position, Vector3.down.normalized, out var hitInfo, 20f, 1) || Physics.Raycast(position, Vector3.up.normalized, out hitInfo, 5f, 1))
			{
				portalAnchor.position = hitInfo.point + Vector3.up;
				portalAnchor.SetParent(hitInfo.transform, worldPositionStays: true);
			}
			if (!base.IsFirstperson)
			{
				_disable = true;
			}
		}

		protected override void OnAnimationEnded()
		{
			base.OnAnimationEnded();
			if (!_disable)
			{
				Scp106Hud.SetDissolveAnimation(0f);
				_disable = true;
			}
		}
	}
}
