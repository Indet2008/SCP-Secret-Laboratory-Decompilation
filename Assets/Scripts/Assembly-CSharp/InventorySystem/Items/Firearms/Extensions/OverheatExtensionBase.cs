using System.Collections.Generic;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public abstract class OverheatExtensionBase : MixedExtension, IDestroyExtensionReceiver
	{
		private static readonly Queue<OverheatExtensionBase> WorldmodelUpdateQueue = new Queue<OverheatExtensionBase>();

		private static readonly HashSet<OverheatExtensionBase> WorldmodelInstances = new HashSet<OverheatExtensionBase>();

		private bool _worldmodelSetup;

		public override void SetupWorldmodel(FirearmWorldmodel worldmodel)
		{
			base.SetupWorldmodel(worldmodel);
			if (!_worldmodelSetup)
			{
				_worldmodelSetup = true;
				WorldmodelInstances.Add(this);
				WorldmodelUpdateQueue.Enqueue(this);
			}
		}

		public virtual void OnDestroyExtension()
		{
			if (_worldmodelSetup)
			{
				WorldmodelInstances.Remove(this);
			}
		}

		protected abstract void OnTemperatureChanged(float temp);

		protected virtual void Update()
		{
			if (base.ViewmodelMode)
			{
				UpdateInstance();
			}
		}

		private void UpdateInstance()
		{
			OnTemperatureChanged(TemperatureTrackerModule.GetTemperature(base.Identifier));
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			TemperatureTrackerModule.OnTemperatureSet += OnTemperatureSet;
			StaticUnityMethods.OnUpdate += UpdateWorldmodels;
		}

		private static void OnTemperatureSet(ItemIdentifier id)
		{
			foreach (OverheatExtensionBase worldmodelInstance in WorldmodelInstances)
			{
				if (!(worldmodelInstance.Identifier != id))
				{
					worldmodelInstance.UpdateInstance();
				}
			}
		}

		private static void UpdateWorldmodels()
		{
			if (WorldmodelUpdateQueue.TryDequeue(out var result) && !(result == null))
			{
				result.UpdateInstance();
				WorldmodelUpdateQueue.Enqueue(result);
			}
		}
	}
}
