using UnityEngine;

namespace OperationalGuide
{
	public class SetAnimatorSpeed : MonoBehaviour
	{
		private static readonly int Speed = Animator.StringToHash("Speed");

		public Animator Animator;

		public float CustomSpeed;

		private void Start()
		{
			Animator.SetFloat(Speed, CustomSpeed);
		}

		private void OnEnable()
		{
			Animator.SetFloat(Speed, CustomSpeed);
		}
	}
}
