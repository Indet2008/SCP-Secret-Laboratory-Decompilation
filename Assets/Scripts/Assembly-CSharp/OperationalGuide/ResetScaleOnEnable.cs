using UnityEngine;

namespace OperationalGuide
{
	public class ResetScaleOnEnable : MonoBehaviour
	{
		private void OnEnable()
		{
			Transform parent = base.transform.parent;
			base.transform.parent = null;
			base.transform.localScale = Vector3.one;
			base.transform.parent = parent;
		}
	}
}
