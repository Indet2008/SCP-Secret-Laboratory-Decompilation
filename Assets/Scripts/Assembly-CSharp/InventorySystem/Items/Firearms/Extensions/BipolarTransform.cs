using System;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	[Serializable]
	public class BipolarTransform
	{
		public Transform TargetTransform;

		[Space(15f)]
		public Offset TruePole;

		public Offset FalsePole;

		private bool _polarity;

		public bool Polarity
		{
			get
			{
				return _polarity;
			}
			set
			{
				if (_polarity != value)
				{
					_polarity = value;
					Offset offset = (value ? TruePole : FalsePole);
					Quaternion localRotation = Quaternion.Euler(offset.rotation);
					TargetTransform.localScale = offset.scale;
					TargetTransform.SetLocalPositionAndRotation(offset.position, localRotation);
				}
			}
		}
	}
}
