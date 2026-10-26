using UnityEngine;

namespace ProgressiveCulling
{
	public abstract class CullableBehaviour : MonoBehaviour, ICullable
	{
		private bool? _prevVisible;

		public bool IsCulled
		{
			get
			{
				if (_prevVisible.HasValue)
				{
					return !_prevVisible.Value;
				}
				return false;
			}
		}

		public abstract bool ShouldBeVisible { get; }

		protected bool EditorShowGizmos { get; private set; }

		public void SetVisibility(bool isVisible)
		{
			if (_prevVisible == isVisible)
			{
				if (isVisible)
				{
					UpdateVisible();
				}
				else
				{
					UpdateInvisible();
				}
			}
			else
			{
				_prevVisible = isVisible;
				OnVisibilityChanged(isVisible);
			}
		}

		protected virtual void UpdateVisible()
		{
		}

		protected virtual void UpdateInvisible()
		{
		}

		protected abstract void OnVisibilityChanged(bool isVisible);

		protected virtual void OnDrawGizmosSelected()
		{
		}
	}
}
