internal class ScreenSpaceCameraUIBlur : global::UnityEngine.Rendering.HighDefinition.CustomPass
{
	public float blurRadius = 10f;

	public global::UnityEngine.LayerMask uiLayer = 32;

	[global::UnityEngine.Range(0f, 1f)]
	public float darkenAmount = 0.2f;

	private global::UnityEngine.Rendering.RTHandle downSampleBuffer;

	private global::UnityEngine.Material darkenMaterial;

	private readonly int _intensityId = global::UnityEngine.Shader.PropertyToID("_DarknessIntensity");

	protected override void Setup(global::UnityEngine.Rendering.ScriptableRenderContext renderContext, global::UnityEngine.Rendering.CommandBuffer cmd)
	{
		if (base.injectionPoint != global::UnityEngine.Rendering.HighDefinition.CustomPassInjectionPoint.AfterPostProcess)
		{
			global::UnityEngine.Debug.LogWarning("Custom Pass UI Blur isn't using the after post process injection point. Your post processes will be applied to the UI");
		}
		global::UnityEngine.Shader shader = global::UnityEngine.Shader.Find("Hidden/Renderers/Darken");
		darkenMaterial = global::UnityEngine.Rendering.CoreUtils.CreateEngineMaterial(shader);
		downSampleBuffer = global::UnityEngine.Rendering.RTHandles.Alloc(global::UnityEngine.Vector2.one * 0.5f, global::UnityEngine.Rendering.TextureXR.slices, global::UnityEngine.Rendering.DepthBits.None, global::UnityEngine.Experimental.Rendering.GraphicsFormat.B10G11R11_UFloatPack32, global::UnityEngine.FilterMode.Point, global::UnityEngine.TextureWrapMode.Repeat, global::UnityEngine.Rendering.TextureXR.dimension, enableRandomWrite: false, useMipMap: false, autoGenerateMips: true, isShadowMap: false, 1, 0f, global::UnityEngine.Rendering.MSAASamples.None, bindTextureMS: false, useDynamicScale: true, useDynamicScaleExplicit: false, global::UnityEngine.RenderTextureMemoryless.None, global::UnityEngine.VRTextureUsage.None, "DownSampleBuffer");
	}

	protected override void AggregateCullingParameters(ref global::UnityEngine.Rendering.ScriptableCullingParameters cullingParameters, global::UnityEngine.Rendering.HighDefinition.HDCamera hdCamera)
	{
		cullingParameters.cullingMask |= (uint)uiLayer.value;
	}

	protected override void Execute(global::UnityEngine.Rendering.HighDefinition.CustomPassContext ctx)
	{
		if (ctx.hdCamera.camera.cameraType != global::UnityEngine.CameraType.SceneView)
		{
			darkenMaterial.SetFloat(_intensityId, darkenAmount);
			ctx.cmd.Blit(ctx.cameraColorBuffer, ctx.cameraColorBuffer, darkenMaterial);
			global::UnityEngine.Rendering.HighDefinition.CustomPassUtils.GaussianBlur(in ctx, ctx.cameraColorBuffer, ctx.cameraColorBuffer, downSampleBuffer, 9, blurRadius);
			global::UnityEngine.Rendering.CoreUtils.SetRenderTarget(ctx.cmd, ctx.cameraColorBuffer, ctx.customDepthBuffer.Value, global::UnityEngine.Rendering.ClearFlag.DepthStencil, global::UnityEngine.Color.clear);
			global::UnityEngine.Rendering.HighDefinition.CustomPassUtils.DrawRenderers(in ctx, uiLayer, global::UnityEngine.Rendering.HighDefinition.CustomPass.RenderQueueType.Transparent, null, 0, default, global::UnityEngine.Rendering.SortingCriteria.CommonTransparent);
		}
	}

	protected override void Cleanup()
	{
		downSampleBuffer.Release();
	}
}
