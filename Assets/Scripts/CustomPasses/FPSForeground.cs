[global::System.Serializable]
public class FPSForeground : global::UnityEngine.Rendering.HighDefinition.CustomPass
{
	private static global::UnityEngine.Rendering.ShaderTagId[] _litForwardTags;

	private static global::UnityEngine.Rendering.ShaderTagId[] _depthTags;

	public global::UnityEngine.LayerMask foregroundMask;

	public global::UnityEngine.Rendering.HighDefinition.CustomPass.RenderQueueType renderQueueType;

	public global::UnityEngine.Camera foregroundCamera;

	public bool depthPass;

	public bool clearDepth;

	public bool overrideBlendState;

	public bool overrideDepthState;

	public bool writeDepth = true;

	public global::UnityEngine.Rendering.CompareFunction compareFunction = global::UnityEngine.Rendering.CompareFunction.Less;

	private global::UnityEngine.Material depthClearMaterial;

	private global::UnityEngine.Rendering.RenderStateBlock block;

	private string ShaderName { get; } = "Hidden/Renderers/ForegroundDepthClear";

	protected override void AggregateCullingParameters(ref global::UnityEngine.Rendering.ScriptableCullingParameters cullingParameters, global::UnityEngine.Rendering.HighDefinition.HDCamera hdCamera)
	{
		cullingParameters.cullingMask |= (uint)foregroundMask.value;
	}

	protected override void Setup(global::UnityEngine.Rendering.ScriptableRenderContext renderContext, global::UnityEngine.Rendering.CommandBuffer cmd)
	{
		global::UnityEngine.Shader shader = global::UnityEngine.Shader.Find(ShaderName);
		if (shader != null)
		{
			depthClearMaterial = new global::UnityEngine.Material(shader);
		}
		else
		{
			global::UnityEngine.Debug.LogError("Unable to find shader '" + ShaderName + "'. FPS Foreground is unable to load.");
		}
		block = default;
		if (overrideBlendState)
		{
			block.mask |= global::UnityEngine.Rendering.RenderStateMask.Blend;
			block.blendState = new global::UnityEngine.Rendering.BlendState(false, false)
			{
				blendState0 = new global::UnityEngine.Rendering.RenderTargetBlendState(global::UnityEngine.Rendering.ColorWriteMask.All, global::UnityEngine.Rendering.BlendMode.One, global::UnityEngine.Rendering.BlendMode.Zero, global::UnityEngine.Rendering.BlendMode.One, global::UnityEngine.Rendering.BlendMode.Zero, global::UnityEngine.Rendering.BlendOp.Add, global::UnityEngine.Rendering.BlendOp.Add)
			};
		}
		if (overrideDepthState)
		{
			block.mask |= global::UnityEngine.Rendering.RenderStateMask.Depth;
			block.depthState = new global::UnityEngine.Rendering.DepthState(writeDepth, compareFunction);
		}
		_litForwardTags = new global::UnityEngine.Rendering.ShaderTagId[3]
		{
			global::UnityEngine.Rendering.HighDefinition.HDShaderPassNames.s_ForwardOnlyName,
			global::UnityEngine.Rendering.HighDefinition.HDShaderPassNames.s_ForwardName,
			global::UnityEngine.Rendering.HighDefinition.HDShaderPassNames.s_SRPDefaultUnlitName
		};
		_depthTags = new global::UnityEngine.Rendering.ShaderTagId[2]
		{
			global::UnityEngine.Rendering.HighDefinition.HDShaderPassNames.s_DepthForwardOnlyName,
			global::UnityEngine.Rendering.HighDefinition.HDShaderPassNames.s_DepthOnlyName
		};
	}

	private void OnValidate()
	{
		Execute(default);
	}

	protected override void Execute(global::UnityEngine.Rendering.HighDefinition.CustomPassContext ctx)
	{
		if (ctx.hdCamera.camera.cameraType != global::UnityEngine.CameraType.SceneView)
		{
			if (clearDepth || depthPass)
			{
				global::UnityEngine.Rendering.CoreUtils.SetKeyword(ctx.cmd, "WRITE_NORMAL_BUFFER", state: true);
			}
			if (clearDepth)
			{
				RenderFromCamera(in ctx, foregroundCamera, ctx.cameraNormalBuffer, ctx.cameraDepthBuffer, global::UnityEngine.Rendering.ClearFlag.None, foregroundMask, depthTags: true, renderQueueType, block, depthClearMaterial);
			}
			if (depthPass)
			{
				RenderFromCamera(in ctx, foregroundCamera, ctx.cameraNormalBuffer, ctx.cameraDepthBuffer, global::UnityEngine.Rendering.ClearFlag.None, foregroundMask, depthTags: true, renderQueueType, block);
			}
			if (clearDepth || depthPass)
			{
				global::UnityEngine.Rendering.CoreUtils.SetKeyword(ctx.cmd, "WRITE_NORMAL_BUFFER", state: false);
			}
			if (!clearDepth && !depthPass)
			{
				RenderFromCamera(in ctx, foregroundCamera, ctx.cameraColorBuffer, ctx.cameraDepthBuffer, global::UnityEngine.Rendering.ClearFlag.None, foregroundMask, depthTags: false, renderQueueType, block);
			}
		}
	}

	public void RenderFromCamera(in global::UnityEngine.Rendering.HighDefinition.CustomPassContext ctx, global::UnityEngine.Camera view, global::UnityEngine.Rendering.RTHandle targetColor, global::UnityEngine.Rendering.RTHandle targetDepth, global::UnityEngine.Rendering.ClearFlag clearFlag, global::UnityEngine.LayerMask layerMask, bool depthTags, global::UnityEngine.Rendering.HighDefinition.CustomPass.RenderQueueType renderQueueFilter, global::UnityEngine.Rendering.RenderStateBlock overrideRenderState, global::UnityEngine.Material overrideMaterial = null)
	{
		if (targetColor != null && targetDepth != null)
		{
			global::UnityEngine.Rendering.CoreUtils.SetRenderTarget(ctx.cmd, targetColor, targetDepth, clearFlag);
		}
		else if (targetColor != null)
		{
			global::UnityEngine.Rendering.CoreUtils.SetRenderTarget(ctx.cmd, targetColor, clearFlag);
		}
		else if (targetDepth != null)
		{
			global::UnityEngine.Rendering.CoreUtils.SetRenderTarget(ctx.cmd, targetDepth, clearFlag);
		}
		using (new global::UnityEngine.Rendering.HighDefinition.CustomPassUtils.DisableSinglePassRendering(in ctx))
		{
			using (new global::UnityEngine.Rendering.HighDefinition.CustomPassUtils.OverrideCameraRendering(ctx, view))
			{
				global::UnityEngine.Rendering.HighDefinition.CustomPassUtils.DrawRenderers(in ctx, depthTags ? _depthTags : _litForwardTags, layerMask, renderQueueFilter, overrideMaterial, 0, overrideRenderState);
			}
		}
	}

	protected override void Cleanup()
	{
		global::UnityEngine.Rendering.CoreUtils.Destroy(depthClearMaterial);
	}
}
