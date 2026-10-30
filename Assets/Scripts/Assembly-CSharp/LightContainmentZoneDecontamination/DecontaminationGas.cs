using System.Collections.Generic;
using ProgressiveCulling;
using UnityEngine;

namespace LightContainmentZoneDecontamination
{
	public class DecontaminationGas : MonoBehaviour, IAutoCullerOverrideComponent
	{
		private static readonly List<DecontaminationGas> AllInstances = new List<DecontaminationGas>();

		private static bool _turnedOn;

		public bool AllowAutoCulling => false;

		public static bool TurnedOn
		{
			get
			{
				return _turnedOn;
			}
			set
			{
				_turnedOn = value;
				for (int num = AllInstances.Count - 1; num >= 0; num--)
				{
					DecontaminationGas decontaminationGas = AllInstances[num];
					if (decontaminationGas == null)
					{
						AllInstances.RemoveAt(num);
					}
					else
					{
						decontaminationGas.gameObject.SetActive(value);
					}
				}
			}
		}

		[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
		private static void ResetStatics()
		{
			AllInstances.Clear();
			_turnedOn = false;
		}

		private void Start()
		{
			if (!AllInstances.Contains(this))
			{
				AllInstances.Add(this);
			}
			base.gameObject.SetActive(_turnedOn);
		}

		private void OnDestroy()
		{
			AllInstances.Remove(this);
		}
	}
}
