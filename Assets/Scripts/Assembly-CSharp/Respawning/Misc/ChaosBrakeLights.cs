namespace Respawning.Misc
{
	public class ChaosBrakeLights : global::UnityEngine.MonoBehaviour
	{
		private bool _prevState;

		public bool State;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.MeshRenderer _renderer;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Material _onMat;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Material _offMat;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Light _leftBrake;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Light _rightBrake;

		private void Update()
		{
		}

		public ChaosBrakeLights()
		{
		}
	}
}
