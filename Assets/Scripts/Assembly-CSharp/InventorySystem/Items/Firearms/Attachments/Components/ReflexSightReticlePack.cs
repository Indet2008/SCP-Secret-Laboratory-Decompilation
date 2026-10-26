using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments.Components
{
	[CreateAssetMenu(fileName = "New Sight Pack", menuName = "ScriptableObject/Firearms/Reflex Sight Pack")]
	public class ReflexSightReticlePack : ScriptableObject
	{
		public Texture[] Reticles;

		public Texture this[int index] => Reticles[index];

		public int Length => Reticles.Length;
	}
}
