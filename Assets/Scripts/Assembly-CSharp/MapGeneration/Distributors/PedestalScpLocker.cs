namespace MapGeneration.Distributors
{
	public class PedestalScpLocker : Locker
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.Header("Pedestal settings")]
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Renderer _lightRenderer;

		[global::UnityEngine.SerializeField]
		private int _lightMaterialId;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Light _lightSource;

		[global::UnityEngine.SerializeField]
		private float _lightIdleIntensity;

		[global::UnityEngine.SerializeField]
		private float _lightSpeed;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Transform _detectionOrigin;

		[global::UnityEngine.SerializeField]
		private float _detectionRayLength;


		public override bool Weaved()
		{
			return true;
		}
	}
}
