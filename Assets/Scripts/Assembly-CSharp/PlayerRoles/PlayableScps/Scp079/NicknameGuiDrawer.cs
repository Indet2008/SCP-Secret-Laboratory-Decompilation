using System.Collections.Generic;
using PlayerRoles.FirstPersonControl.Thirdperson;
using TMPro;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	// Restored from the client build (IL2CPP): draws a box (and the nickname on hover) over players seen through a camera.
	public class NicknameGuiDrawer : MonoBehaviour
	{
		private const float MaxDistancePerZoom = 17f;

		private const float SizeMultiplier = 270f;

		private const float MinSize = 3f;

		private static readonly Vector3 ScpHeadOffset = new Vector3(0f, 1.5f, 0f);

		private static int _visibilityMask;

		// Resolved lazily: the static constructor runs inside AddComponent, where Unity forbids NameToLayer.
		private static int VisibilityMask
		{
			get
			{
				if (_visibilityMask == 0)
				{
					_visibilityMask = LayerMask.GetMask("Default");
				}
				return _visibilityMask;
			}
		}

		private Camera _cam;

		private RectTransform _fullscreenRect;

		private RectTransform _template;

		private bool _forceShowNicknames;

		private readonly Queue<RectTransform> _pool = new Queue<RectTransform>();

		private readonly HashSet<RectTransform> _instances = new HashSet<RectTransform>();

		public void Init(Camera cam, RectTransform fullScreenRect, RectTransform template, bool forceShowNicknames = false)
		{
			_cam = cam;
			_fullscreenRect = fullScreenRect;
			_template = template;
			_forceShowNicknames = forceShowNicknames;
			_template.gameObject.SetActive(false);
		}

		public void TryDrawPlayer(CharacterModel model, string nickname, float zoom, Vector3 curPos, bool isScp = false)
		{
			if (model == null)
			{
				return;
			}
			Vector3 pos;
			HitboxIdentity[] hitboxes = model.Hitboxes;
			if (!isScp && hitboxes != null && hitboxes.Length != 0 && hitboxes[0].TryGetComponent<CapsuleCollider>(out var capsule))
			{
				pos = capsule.transform.TransformPoint(capsule.center);
			}
			else
			{
				pos = model.transform.position + ScpHeadOffset;
			}
			DrawRectangleIfVisible(pos, zoom, nickname, curPos);
		}

		private void DrawRectangleIfVisible(Vector3 pos, float zoom, string nickname, Vector3 curPos)
		{
			if ((pos - curPos).sqrMagnitude > Mathf.Pow(MaxDistancePerZoom * zoom, 2f))
			{
				return;
			}
			if (!Physics.Linecast(curPos, pos, VisibilityMask))
			{
				DrawRectangle(pos, zoom, nickname, curPos);
			}
		}

		private void DrawRectangle(Vector3 targetPos, float zoom, string nickname, Vector3 curPos)
		{
			Vector3 screen = _cam.WorldToScreenPoint(targetPos);
			if (screen.z <= 0f)
			{
				return;
			}
			if (!_pool.TryDequeue(out var rect) || rect == null)
			{
				rect = Object.Instantiate(_template, _template.parent);
			}
			Vector2 full = _fullscreenRect.sizeDelta;
			rect.anchoredPosition = new Vector2(screen.x / Screen.width * full.x, screen.y / Screen.height * full.y);
			float distance = Mathf.Max(Vector3.Distance(curPos, targetPos), 0.01f);
			float size = SizeMultiplier * zoom / distance + MinSize;
			rect.sizeDelta = new Vector2(size, size);
			rect.gameObject.SetActive(true);
			TextMeshProUGUI text = rect.GetComponentInChildren<TextMeshProUGUI>();
			if (text != null)
			{
				float halfPixels = size * 0.5f * Screen.height / Mathf.Max(full.y, 1f);
				Vector3 mouse = Input.mousePosition;
				bool hovered = Mathf.Abs(mouse.x - screen.x) <= halfPixels && Mathf.Abs(mouse.y - screen.y) <= halfPixels;
				text.text = (_forceShowNicknames || hovered) ? nickname : string.Empty;
			}
			_instances.Add(rect);
		}

		public void ClearAll()
		{
			foreach (RectTransform instance in _instances)
			{
				if (instance != null)
				{
					instance.gameObject.SetActive(false);
					_pool.Enqueue(instance);
				}
			}
			_instances.Clear();
		}
	}
}
