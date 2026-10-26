using MapGeneration;
using TMPro;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Map
{
	public class LczMap : ProceduralZoneMap
	{
		private const float UnnamedAlpha = 0.2f;

		private const float UnnamedSize = 0.7f;

		private const int RoomIdOffset = 1;

		[SerializeField]
		private ProceduralZoneMap _hczMap;

		[SerializeField]
		private ProceduralZoneMap _ezMap;

		[SerializeField]
		private Vector2 _spacing;

		protected override void PlaceRooms()
		{
			base.PlaceRooms();
		}

		protected override void PostProcessRooms()
		{
			base.PostProcessRooms();
			Vector2 vector = _hczMap.RectBounds.center - base.RectBounds.center;
			vector += Vector2.up * (_spacing.y + _hczMap.RectBounds.extents.y + base.RectBounds.extents.y);
			vector += Vector2.right * (base.RectBounds.extents.x + _spacing.x - _hczMap.RectBounds.extents.x);
			foreach (RoomNode allNode in AllNodes)
			{
				ProcessName(allNode);
				allNode.Transform.anchoredPosition += vector;
			}
			ZoneLabel.rectTransform.anchoredPosition += vector;
			base.RectBounds = new Bounds(base.RectBounds.center + (Vector3)vector, base.RectBounds.size);
		}

		private void ProcessName(RoomNode node)
		{
			if (node.Room.Name == RoomName.Unnamed && node.Room.TryGetComponent<SpawnableRoom>(out var component))
			{
				TextMeshProUGUI componentInChildren = node.Icon.GetComponentInChildren<TextMeshProUGUI>();
				componentInChildren.text = string.Format(componentInChildren.text, (1 + component.DuplicateId).ToString("00"));
				componentInChildren.alpha = 0.2f;
				componentInChildren.fontSize *= 0.7f;
			}
		}
	}
}
