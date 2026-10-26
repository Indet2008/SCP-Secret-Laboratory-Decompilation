public class CustomFog : global::UnityEngine.Rendering.HighDefinition.CustomPass
{
	private readonly int _fogColorId = global::UnityEngine.Shader.PropertyToID("_CustomFogColor");

	private readonly int _distanceParamsId = global::UnityEngine.Shader.PropertyToID("_DistanceParams");

	[global::UnityEngine.ColorUsage(false, true)]
	public global::UnityEngine.Color FogColor = global::UnityEngine.Color.black;

	[global::UnityEngine.Range(0f, 1f)]
	public float FadeIntensity = 1f;

	public float EndDistance = 200f;

	public float StartDistance;

	[global::UnityEngine.Range(0f, 1f)]
	public float CoverSkybox = 1f;

	private global::UnityEngine.Material _fogMaterial;

	protected override void Setup(global::UnityEngine.Rendering.ScriptableRenderContext renderContext, global::UnityEngine.Rendering.CommandBuffer cmd)
	{
		global::UnityEngine.Shader shader = global::UnityEngine.Shader.Find("Hidden/Renderers/CustomFog");
		_fogMaterial = global::UnityEngine.Rendering.CoreUtils.CreateEngineMaterial(shader);
	}

	protected override void Execute(global::UnityEngine.Rendering.HighDefinition.CustomPassContext ctx)
	{
		SetRenderTargetAuto(ctx.cmd);
		_fogMaterial.SetColor(_fogColorId, FogColor);
		_fogMaterial.SetVector(_distanceParamsId, new global::UnityEngine.Vector4(StartDistance, EndDistance, FadeIntensity, CoverSkybox));
		global::UnityEngine.Rendering.CoreUtils.DrawFullScreen(ctx.cmd, _fogMaterial);
	}

	public override global::System.Collections.Generic.IEnumerable<global::UnityEngine.Material> RegisterMaterialForInspector()
	{
		yield return _fogMaterial;
	}
}
