using PlayerRoles.PlayableScps.HUDs;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079Hud : ScpHudBase
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Camera _mainCamera;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Rendering.HighDefinition.CustomPassVolume _hudCustomPass;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject[] _aliveObjects;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Rendering.Volume _deathVolume;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Gradient _deathBarsColor;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.RawImage _deathBars;

		[global::UnityEngine.SerializeField]
		private float _deathAnimSpeed;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.Scp079.GUI.Scp079NoiseController _noiseController;


		public static Camera MainCamera { get; private set; }

		public static Scp079Role Instance { get; private set; }
	}
}
