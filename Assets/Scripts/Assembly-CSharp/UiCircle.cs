using System;
using UnityEngine;
using UnityEngine.UI;

public class UiCircle : MaskableGraphic
{
	[Range(3f, 180f)]
	[SerializeField]
	private int _vertsCount = 64;

	[SerializeField]
	private float _radius;

	[SerializeField]
	private float _width;

	public float Radius
	{
		get
		{
			return _radius;
		}
		set
		{
			_radius = value;
			SetVerticesDirty();
		}
	}

	public float Width
	{
		get
		{
			return _width;
		}
		set
		{
			_width = value;
			SetVerticesDirty();
		}
	}

	protected override void OnPopulateMesh(VertexHelper vh)
	{
		vh.Clear();
		UIVertex simpleVert = UIVertex.simpleVert;
		simpleVert.color = color;
		float radius = Radius;
		float num = Radius - Width;
		DrawVertCircle(vh, simpleVert, radius);
		if (num <= 0f)
		{
			RenderFullCircle(vh, simpleVert);
			return;
		}
		DrawVertCircle(vh, simpleVert, num);
		for (int i = 0; i < _vertsCount; i++)
		{
			vh.AddTriangle(i, (i + 1) % _vertsCount, i + _vertsCount);
			vh.AddTriangle(i, i + _vertsCount, (i - 1 + _vertsCount) % _vertsCount + _vertsCount);
		}
	}

	private void DrawVertCircle(VertexHelper vh, UIVertex vert, float radius)
	{
		float num = MathF.PI * 2f / (float)_vertsCount;
		float num2 = 0f;
		for (int i = 0; i < _vertsCount; i++)
		{
			float num3 = Mathf.Sin(num2);
			float num4 = Mathf.Sin(num2 + MathF.PI / 2f);
			vert.position = new Vector2(num3 * radius, num4 * radius);
			vh.AddVert(vert);
			num2 += num;
		}
	}

	private void RenderFullCircle(VertexHelper vh, UIVertex vert)
	{
		vert.position = Vector2.zero;
		vh.AddVert(vert);
		for (int i = 0; i < _vertsCount; i++)
		{
			vh.AddTriangle(i, (i + 1) % _vertsCount, _vertsCount);
		}
	}
}
