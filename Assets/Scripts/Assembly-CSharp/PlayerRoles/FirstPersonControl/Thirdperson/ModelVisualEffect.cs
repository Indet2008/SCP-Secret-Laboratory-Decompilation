using System;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson
{
	public class ModelVisualEffect
	{
		private CharacterModel _model;

		private bool _isApplied;

		public ModelVisualEffect(CharacterModel model, Material mat)
		{
			if (model == null)
			{
				return;
			}
			_model = model;
			model.RestoreOriginalMaterials();
			model.SetOriginalMaterials();
			ReadOnlySpan<Renderer> renderers = model.Renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				Renderer renderer = renderers[i];
				int num = renderer.sharedMaterials.Length;
				Material[] array = new Material[num];
				for (int j = 0; j < num; j++)
				{
					array[j] = mat;
				}
				renderer.sharedMaterials = array;
			}
			_isApplied = true;
		}

		public void Restore()
		{
			if (!(_model == null) && _isApplied)
			{
				_model.RestoreOriginalMaterials();
				_isApplied = false;
				_model = null;
			}
		}
	}
}
