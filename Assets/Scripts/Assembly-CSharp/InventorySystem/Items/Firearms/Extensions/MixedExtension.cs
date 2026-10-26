using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public abstract class MixedExtension : MonoBehaviour, IWorldmodelExtension, IViewmodelExtension
	{
		public const int ViewmodelLayer = 10;

		public const int Worldmodellayer = 9;

		protected ItemIdentifier Identifier { get; private set; }

		protected FirearmWorldmodel Worldmodel { get; private set; }

		protected bool WorldmodelMode { get; private set; }

		protected bool ViewmodelMode { get; private set; }

		protected AnimatedFirearmViewmodel Viewmodel { get; private set; }

		public virtual void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			Identifier = viewmodel.ItemId;
			Viewmodel = viewmodel;
			ViewmodelMode = true;
			SetupAny();
		}

		public virtual void SetupWorldmodel(FirearmWorldmodel worldmodel)
		{
			Identifier = worldmodel.Identifier;
			Worldmodel = worldmodel;
			WorldmodelMode = true;
			SetupAny();
		}

		public virtual void SetupAny()
		{
		}

		protected void SetLayer(int layer)
		{
			SetLayer(layer, base.transform);
		}

		private void SetLayer(int layer, Transform t)
		{
			t.gameObject.layer = layer;
			int childCount = t.childCount;
			for (int i = 0; i < childCount; i++)
			{
				SetLayer(layer, t.GetChild(i));
			}
		}
	}
}
