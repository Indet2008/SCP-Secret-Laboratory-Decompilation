using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

namespace InventorySystem.Items.MarshmallowMan
{
	public class MarshmallowModel : AnimatedCharacterModel
	{
		private static readonly int HashGrounded = Animator.StringToHash("Grounded");

		[SerializeField]
		private GameObject _stache;

		private MeshRenderer _mesh;

		public override void SetVisibility(bool newState)
		{
			base.SetVisibility(newState);
			float t = Mathf.Clamp01(Random.Range(0f, 2f));
			Color value = Color.Lerp(Color.black, Color.white, t);
			_mesh.material.SetColor("_Color", value);
		}

		protected override void Awake()
		{
			base.Awake();
			_mesh = _stache.GetComponent<MeshRenderer>();
		}

		protected override void Update()
		{
			base.Update();
			if (!base.Pooled)
			{
				_stache.SetActive(MarshmallowItem.EvilInstances.Contains(base.OwnerHub.inventory.CurItem.SerialNumber));
				base.Animator.SetBool(HashGrounded, base.FpcModule.Noclip.IsActive || base.FpcModule.IsGrounded);
			}
		}
	}
}
