using PlayerRoles;
using UnityEngine;
using UnityEngine.UI;

public class InterfaceColorAdjuster : MonoBehaviour
{
	public Graphic[] graphicsToChange;

	private void Awake()
	{
		PlayerList.ica = this;
		PlayerRoleManager.OnRoleChanged += OnRoleChanged;
	}

	private void Start()
	{
		if (ReferenceHub.TryGetLocalHub(out var hub))
		{
			ChangeColor(hub.roleManager.CurrentRole.RoleColor);
		}
	}

	private void OnDestroy()
	{
		PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
		if (PlayerList.ica == this)
		{
			PlayerList.ica = null;
		}
	}

	private void OnRoleChanged(ReferenceHub hub, PlayerRoleBase oldRole, PlayerRoleBase newRole)
	{
		if (!(hub == null) && hub.isLocalPlayer && !(newRole == null))
		{
			ChangeColor(newRole.RoleColor);
		}
	}

	public void ChangeColor(Color color)
	{
		if (graphicsToChange != null)
		{
			Graphic[] array = graphicsToChange;
			foreach (Graphic graphic in array)
			{
				if (!(graphic == null))
				{
					graphic.color = new Color(color.r, color.g, color.b, graphic.color.a);
				}
			}
		}
		if (GameMenu.singleton != null && GameMenu.singleton.colorableElements != null)
		{
			Graphic[] array = GameMenu.singleton.colorableElements;
			foreach (Graphic graphic2 in array)
			{
				if (!(graphic2 == null))
				{
					graphic2.color = new Color(color.r, color.g, color.b, graphic2.color.a);
				}
			}
		}
		PlayerList.UpdateColors();
	}

	public Color CurrentColor
	{
		get
		{
			if (graphicsToChange != null)
			{
				Graphic[] array = graphicsToChange;
				foreach (Graphic graphic in array)
				{
					if (!(graphic == null))
					{
						Color color = graphic.color;
						color.a = 1f;
						return color;
					}
				}
			}
			return Color.white;
		}
	}
}
