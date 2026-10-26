using UnityEngine;

public class Skybox : MonoBehaviour
{
	[SerializeField]
	private Bounds _bounds;

	[SerializeField]
	private Transform _cubemapTr;

	private Renderer _rend;

	private Bounds _worldspaceBounds;

	private void Start()
	{
		_rend = _cubemapTr.GetComponent<Renderer>();
		CalculateWorldspaceBounds();
		MainCameraController.OnUpdated += OnCamUpdated;
	}

	private void OnDestroy()
	{
		MainCameraController.OnUpdated -= OnCamUpdated;
	}

	private void OnDrawGizmosSelected()
	{
		CalculateWorldspaceBounds();
		Gizmos.color = Color.white;
		Gizmos.DrawWireCube(_worldspaceBounds.center, _worldspaceBounds.size);
	}

	private void CalculateWorldspaceBounds()
	{
		Vector3 center = base.transform.TransformPoint(_bounds.center);
		Vector3 size = (base.transform.rotation * _bounds.size).Abs();
		_worldspaceBounds = new Bounds(center, size);
	}

	private void OnCamUpdated()
	{
		Vector3 lastPosition = MainCameraController.LastPosition;
		bool flag = _worldspaceBounds.Contains(lastPosition);
		_rend.enabled = flag;
		if (flag)
		{
			_cubemapTr.position = lastPosition;
		}
	}
}
