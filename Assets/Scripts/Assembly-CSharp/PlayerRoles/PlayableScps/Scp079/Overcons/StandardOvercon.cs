using MapGeneration;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Overcons
{
	public class StandardOvercon : OverconBase
	{
		[SerializeField]
		private AnimationCurve _scaleOverDistance;

		[SerializeField]
		protected SpriteRenderer TargetSprite;

		private const float SurfaceSizeScale = 2.5f;

		public static readonly Color HighlightedColor = new Color(1f, 1f, 1f, 1f);

		public static readonly Color NormalColor = new Color(1f, 1f, 1f, 0.35f);

		public override bool IsHighlighted
		{
			get
			{
				return base.IsHighlighted;
			}
			internal set
			{
				TargetSprite.color = (value ? HighlightedColor : NormalColor);
				base.IsHighlighted = value;
			}
		}

		protected virtual void Awake()
		{
			TargetSprite.color = NormalColor;
		}

		public void Rescale(Scp079Camera cam)
		{
			Rescale(cam, Vector3.Distance(cam.Position, base.transform.position));
		}

		public void Rescale(Scp079Camera cam, float dis)
		{
			base.transform.LookAt(cam.Position);
			float num = _scaleOverDistance.Evaluate(dis);
			if (cam.Room.Zone == FacilityZone.Surface)
			{
				num *= 2.5f;
			}
			base.transform.localScale = Vector3.one * num;
		}
	}
}
