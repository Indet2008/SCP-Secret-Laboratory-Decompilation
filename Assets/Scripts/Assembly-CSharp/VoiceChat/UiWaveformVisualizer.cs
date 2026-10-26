using System;
using UnityEngine;
using UnityEngine.UI;

namespace VoiceChat
{
	public class UiWaveformVisualizer : Graphic
	{
		private float[] _recordedAverages;

		[field: SerializeField]
		public ushort RenderersCount { get; internal set; } = 128;

		[field: SerializeField]
		public float FlatlineHeight { get; internal set; } = 0.05f;

		[field: SerializeField]
		public bool TwoSidedMode { get; internal set; } = true;

		[field: SerializeField]
		public float MaxNormalizer { get; internal set; } = 30f;

		[field: SerializeField]
		public AnimationCurve CorrectionCurve { get; internal set; } = AnimationCurve.Linear(0f, 0f, 1f, 1f);

		public void Generate(float[] samples)
		{
			Generate(samples, 0, samples.Length);
		}

		public void Generate(float[] samples, int startIndex, int length)
		{
			if (RenderersCount == 0)
			{
				SetVerticesDirty();
				return;
			}
			if (_recordedAverages?.Length == RenderersCount)
			{
				Array.Clear(_recordedAverages, 0, RenderersCount);
			}
			else
			{
				_recordedAverages = new float[RenderersCount];
			}
			float num = 0f;
			float num2 = 0f;
			int num3 = 0;
			int num4 = 0;
			int num5 = length / RenderersCount;
			float num6 = 1f / (float)num5;
			for (int i = 0; i < length; i++)
			{
				float num7 = samples[startIndex + i];
				num = ((!(num7 < 0f)) ? (num + num7) : (num + (0f - num7)));
				num3++;
				if (num3 >= num5)
				{
					float num8 = num * num6;
					_recordedAverages[num4++] = num8;
					num = 0f;
					num3 = 0;
					if (num8 > num2)
					{
						num2 = num8;
					}
					if (num4 >= RenderersCount)
					{
						break;
					}
				}
			}
			float num9 = Mathf.Min(1f / ((num2 <= 0f) ? 1f : num2), MaxNormalizer);
			for (int j = 0; j < RenderersCount; j++)
			{
				_recordedAverages[j] *= num9;
			}
			SetVerticesDirty();
		}

		protected override void OnPopulateMesh(VertexHelper vh)
		{
			vh.Clear();
			Rect rect = base.rectTransform.rect;
			UIVertex simpleVert = UIVertex.simpleVert;
			simpleVert.color = color;
			DrawWaveform(simpleVert, rect.width, rect.height / 2f, vh);
			if (TwoSidedMode)
			{
				DrawWaveform(simpleVert, rect.width, (0f - rect.height) / 2f, vh);
			}
		}

		private void DrawWaveform(UIVertex vert, float rectWidth, float rectHeight, VertexHelper vh)
		{
			float[] recordedAverages = _recordedAverages;
			int num = ((recordedAverages != null) ? recordedAverages.Length : 0);
			float num2 = FlatlineHeight * rectHeight;
			float num3 = rectWidth / 2f;
			vert.position = new Vector2(0f - num3, num2);
			vh.AddVert(vert);
			if (num == 0)
			{
				int num4 = vh.currentVertCount - 1;
				vert.position = new Vector2(num3, num2);
				vh.AddVert(vert);
				vert.position = new Vector2(num3, 0f);
				vh.AddVert(vert);
				vert.position = new Vector2(0f - num3, 0f);
				vh.AddVert(vert);
				vh.AddTriangle(num4, num4 + 2, num4 + 1);
				vh.AddTriangle(num4, num4 + 2, num4 + 3);
				return;
			}
			float y = num2;
			float x = 0f - num3;
			for (int i = 0; i < num; i++)
			{
				float num5 = rectHeight * CorrectionCurve.Evaluate(_recordedAverages[i]) + num2;
				float num6 = rectWidth * (float)i / (float)(num - 1) - num3;
				vert.position = new Vector2(num6, num5);
				vh.AddVert(vert);
				vert.position = new Vector3(x, y);
				vh.AddVert(vert);
				vert.position = new Vector2(num6, 0f);
				vh.AddVert(vert);
				x = num6;
				y = num5;
				int num7 = vh.currentVertCount - 1;
				vh.AddTriangle(num7, num7 - 1, num7 - 2);
				vh.AddTriangle(num7, num7 - 1, num7 - 3);
			}
		}
	}
}
