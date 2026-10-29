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
			if (_prevState != State)
			{
				_prevState = State;
				_renderer.sharedMaterial = (State ? _onMat : _offMat);
				float intensity = (State ? 0.8f : 0.4f);
				_leftBrake.intensity = intensity;
				_rightBrake.intensity = intensity;
			}
		}

		public ChaosBrakeLights()
		{
		}
	}
}
