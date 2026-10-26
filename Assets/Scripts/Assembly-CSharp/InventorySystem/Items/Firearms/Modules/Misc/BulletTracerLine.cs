using CustomRendering;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	// Replacement for the BulletTracer VFX Graph, whose ripped asset cannot run.
	// Draws a short glowing streak travelling from start to end, then fading out.
	public class BulletTracerLine : MonoBehaviour
	{
		private const float BulletSpeed = 250f;

		private const float StreakLength = 4f;

		private const float FadeTime = 0.05f;

		private const float Width = 0.012f;

		private const float FriendlyAlpha = 0.35f;

		private LineRenderer _line;

		private Vector3 _start;

		private Vector3 _end;

		private float _distance;

		private float _elapsed;

		private float _alpha;

		private bool _playing;

		public static BulletTracerLine Create(Transform parent)
		{
			GameObject gameObject = new GameObject("TracerLine");
			gameObject.transform.SetParent(parent, worldPositionStays: false);
			BulletTracerLine bulletTracerLine = gameObject.AddComponent<BulletTracerLine>();
			bulletTracerLine.Setup();
			return bulletTracerLine;
		}

		private void Setup()
		{
			_line = base.gameObject.AddComponent<LineRenderer>();
			_line.useWorldSpace = true;
			_line.positionCount = 2;
			_line.widthMultiplier = Width;
			_line.widthCurve = AnimationCurve.Linear(0f, 0f, 1f, 1f);
			_line.numCapVertices = 2;
			_line.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
			_line.receiveShadows = false;
			_line.sharedMaterial = VfxParticleFallback.GetMaterial("Tracer");
			_line.enabled = false;
		}

		public void Play(Vector3 worldStart, Vector3 worldEnd, bool isFriendly)
		{
			_start = worldStart;
			_end = worldEnd;
			_distance = Vector3.Distance(worldStart, worldEnd);
			_elapsed = 0f;
			_alpha = (isFriendly ? FriendlyAlpha : 1f);
			_playing = _distance > 0.01f;
			_line.enabled = _playing;
			if (_playing)
			{
				UpdateLine();
			}
		}

		private void Update()
		{
			if (_playing)
			{
				_elapsed += Time.deltaTime;
				UpdateLine();
			}
		}

		private void UpdateLine()
		{
			float num = _elapsed * BulletSpeed;
			float num2 = Mathf.Min(num, _distance);
			float num3 = Mathf.Max(0f, num - StreakLength);
			float num4 = Mathf.Max(0f, (num - _distance) / BulletSpeed);
			float num5 = _alpha * (1f - Mathf.Clamp01(num4 / FadeTime));
			if (num3 >= _distance || num5 <= 0f)
			{
				_playing = false;
				_line.enabled = false;
				return;
			}
			Vector3 vector = (_end - _start) / _distance;
			_line.SetPosition(0, _start + vector * num3);
			_line.SetPosition(1, _start + vector * num2);
			Color color = new Color(1f, 1f, 1f, num5);
			_line.startColor = color;
			_line.endColor = color;
		}
	}
}
