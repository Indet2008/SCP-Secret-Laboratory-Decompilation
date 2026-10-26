using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomRendering
{
	public static class CustomPostProcessUtils
	{
		private static readonly int MainTexId = Shader.PropertyToID("_MainTex");

		private static readonly int RTHandleScaleId = Shader.PropertyToID("_RTHandleScale");

		private static readonly int ScreenSizeId = Shader.PropertyToID("_ScreenSize");

		private static readonly int ScreenParamsId = Shader.PropertyToID("_ScreenParams");

		private static readonly int TimeId = Shader.PropertyToID("_Time");

		private static readonly int ZBufferParamsId = Shader.PropertyToID("_ZBufferParams");

		private static readonly int ProjectionParamsId = Shader.PropertyToID("_ProjectionParams");

		private static readonly int InvViewProjMatrixId = Shader.PropertyToID("_InvViewProjMatrix");

		private static readonly int WorldSpaceCameraPosId = Shader.PropertyToID("_WorldSpaceCameraPos_Internal");

		private static readonly int DistanceParamsId = Shader.PropertyToID("_DistanceParams");

		public static Material CreateMaterial(string shaderName)
		{
			Shader shader = Shader.Find(shaderName);
			if (shader == null)
			{
				Debug.LogWarning("Custom post process shader not found: " + shaderName);
				return null;
			}
			return CoreUtils.CreateEngineMaterial(shader);
		}

		public static void SetCommonProperties(Material material, HDCamera camera, RTHandle source)
		{
			if (source != null)
			{
				material.SetTexture(MainTexId, source);
				material.SetVector(RTHandleScaleId, source.rtHandleProperties.rtHandleScale);
			}
			else
			{
				material.SetVector(RTHandleScaleId, Vector4.one);
			}
			float width = camera.actualWidth;
			float height = camera.actualHeight;
			material.SetVector(ScreenSizeId, new Vector4(width, height, 1f / width, 1f / height));
			material.SetVector(ScreenParamsId, new Vector4(width, height, 1f + 1f / width, 1f + 1f / height));
			float time = Time.timeSinceLevelLoad;
			material.SetVector(TimeId, new Vector4(time / 20f, time, time * 2f, time * 3f));
			Camera cam = camera.camera;
			float near = cam.nearClipPlane;
			float far = cam.farClipPlane;
			Vector4 zBuffer = (SystemInfo.usesReversedZBuffer ? new Vector4(-1f + far / near, 1f, (-1f + far / near) / far, 1f / far) : new Vector4(1f - far / near, far / near, (1f - far / near) / far, far / near / far));
			material.SetVector(ZBufferParamsId, zBuffer);
			material.SetVector(ProjectionParamsId, new Vector4(1f, near, far, 1f / far));
			material.SetMatrix(InvViewProjMatrixId, camera.mainViewConstants.invViewProjMatrix);
			material.SetVector(WorldSpaceCameraPosId, camera.mainViewConstants.worldSpaceCameraPos);
		}

		public static void SetDistanceParams(Material material, bool distanceFade, float startDistance, float endDistance, float intensity, float coverSkybox)
		{
			if (!distanceFade)
			{
				startDistance = 0f;
				endDistance = 0.0001f;
			}
			material.SetVector(DistanceParamsId, new Vector4(startDistance, endDistance, intensity, coverSkybox));
		}
	}
}
