using System.Collections.Generic;
using InventorySystem.Items.Firearms.Attachments;
using NorthwoodLib.Pools;
using UnityEngine;

namespace MapGeneration.Scenarios
{
	[CreateAssetMenu(fileName = "MyDistributorScenario", menuName = "Northwood/Map/Distributor Scenario")]
	public class DistributorScenario : ScriptableObject
	{
		public static readonly List<DistributorScenario> Instances = new List<DistributorScenario>();

		[Min(0f)]
		public float MinSelections = 1f;

		[Min(1f)]
		public float MaxSelections = 1f;

		public AttachmentName[] BlacklistedAttachments;

		private readonly List<IScenarioProcessor> _scenarioProcessors = new List<IScenarioProcessor>();

		public void SelectProcessors()
		{
			if (_scenarioProcessors.Count == 0)
			{
				return;
			}
			List<IScenarioProcessor> list = ListPool<IScenarioProcessor>.Shared.Rent(_scenarioProcessors);
			float maxInclusive = (((float)list.Count <= MaxSelections) ? ((float)list.Count) : MaxSelections);
			int num = Mathf.RoundToInt(Random.Range(MinSelections, maxInclusive));
			for (int i = 0; i < num; i++)
			{
				if (list.Count == 0)
				{
					break;
				}
				IScenarioProcessor scenarioProcessor = list.RandomItem();
				scenarioProcessor.Select();
				list.Remove(scenarioProcessor);
			}
			ListPool<IScenarioProcessor>.Shared.Return(list);
		}

		public void Register(IScenarioProcessor processor)
		{
			_scenarioProcessors.Add(processor);
		}

		public void Unregister(IScenarioProcessor processor)
		{
			_scenarioProcessors.Remove(processor);
		}

		private void OnEnable()
		{
			if (!Instances.Contains(this))
			{
				Instances.Add(this);
			}
		}

		private void OnDisable()
		{
			Instances.Remove(this);
		}
	}
}
