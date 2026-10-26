using System.Collections.Generic;
using GameCore;
using MapGeneration;
using MapGeneration.Holidays;
using UnityEngine;

public class ClutterSpawner : MonoBehaviour
{
	[SerializeField]
	private bool IsExclusive;

	[SerializeField]
	private List<ClutterStruct> clutters = new List<ClutterStruct>();

	private void Awake()
	{
		SeedSynchronizer.OnGenerationStage += OnMapStage;
	}

	private void OnDestroy()
	{
		SeedSynchronizer.OnGenerationStage -= OnMapStage;
	}

	private void OnMapStage(MapGenerationPhase stage)
	{
		if (stage == MapGenerationPhase.ComplexDecorationsAndClutter)
		{
			GenerateClutter();
		}
	}

	public void GenerateClutter()
	{
		bool flag = false;
		for (int num = clutters.Count - 1; num >= 0; num--)
		{
			ClutterStruct clutterStruct = clutters[num];
			Console.AddDebugLog("MGCLTR", "Checking spawn conditions for clutter struct \"" + clutterStruct.descriptor + "\" on object \"" + base.gameObject.name + "\"", MessageImportance.LeastImportant, nospace: true);
			if ((bool)clutterStruct.clutterComponent && !clutterStruct.clutterComponent.spawned)
			{
				bool flag2;
				if (clutterStruct.chanceToSpawn <= 0f)
				{
					flag2 = false;
				}
				else if ((float)Random.Range(1, 101) > clutterStruct.chanceToSpawn)
				{
					flag2 = false;
				}
				else
				{
					bool invertTimespan = clutterStruct.invertTimespan;
					bool flag3 = clutterStruct.targetHolidays.IsAnyHolidayActive();
					flag2 = (invertTimespan ? (!flag3) : flag3);
				}
				if (flag2 && (!IsExclusive || !flag))
				{
					clutterStruct.clutterComponent.SpawnClutter();
					flag = true;
				}
				else
				{
					clutterStruct.clutterComponent.gameObject.SetActive(value: false);
					Object.Destroy(clutterStruct.clutterComponent.holderObject);
				}
			}
		}
	}
}
