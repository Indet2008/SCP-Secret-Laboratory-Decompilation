using System.Collections.Generic;

namespace CustomPlayerEffects.Danger
{
	public abstract class ParentDangerBase : DangerStackBase
	{
		public override float DangerValue { get; set; }

		protected List<DangerStackBase> ChildDangers { get; private set; } = new List<DangerStackBase>();

		public override bool IsActive
		{
			get
			{
				ProcessChildren();
				return ChildDangers.Count > 0;
			}
			protected set
			{
				base.IsActive = value;
			}
		}

		private void ProcessChildren()
		{
			DangerValue = 0f;
			for (int num = ChildDangers.Count - 1; num >= 0; num--)
			{
				if (!ChildDangers[num].IsActive)
				{
					ChildDangers.RemoveAt(num);
				}
				else
				{
					DangerValue += ChildDangers[num].DangerValue;
				}
			}
		}

		public override void Dispose()
		{
			base.Dispose();
			ChildDangers.Clear();
		}
	}
}
