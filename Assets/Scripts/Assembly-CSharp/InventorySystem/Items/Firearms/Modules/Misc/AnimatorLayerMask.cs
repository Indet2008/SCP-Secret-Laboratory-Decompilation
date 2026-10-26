using System;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	[Serializable]
	public class AnimatorLayerMask
	{
		[SerializeField]
		private int _maskValue;

		private int _cachedMaskValue;

		private int[] _cachedMaskArray;

		public int[] Layers
		{
			get
			{
				if (_cachedMaskValue == _maskValue && _cachedMaskArray != null)
				{
					return _cachedMaskArray;
				}
				uint num = (uint)_maskValue;
				int num2 = 0;
				while (num != 0)
				{
					num2++;
					num &= num - 1;
				}
				if (_cachedMaskArray == null || _cachedMaskArray.Length != num2)
				{
					_cachedMaskArray = new int[num2];
				}
				for (int i = 0; i < 32; i++)
				{
					int num3 = 1 << i;
					if (num3 > _maskValue)
					{
						break;
					}
					if ((_maskValue & num3) != 0)
					{
						_cachedMaskArray[--num2] = i;
					}
				}
				_cachedMaskValue = _maskValue;
				return _cachedMaskArray;
			}
			set
			{
				_maskValue = 0;
				value.ForEach((int x) =>
				{
					SetLayer(x, state: true);
				});
			}
		}

		public void SetLayer(int layerIndex, bool state)
		{
			int num = 1 << layerIndex;
			if (state)
			{
				_maskValue |= num;
			}
			else
			{
				_maskValue &= ~num;
			}
		}

		public bool GetLayer(int layerIndex)
		{
			int num = 1 << layerIndex;
			return (_maskValue & num) == num;
		}

		public void SetWeight(Animator anim, float weight)
		{
			SetWeight(anim.SetLayerWeight, weight);
		}

		public void SetWeight(Action<int, float> setter, float weight)
		{
			int[] layers = Layers;
			foreach (int arg in layers)
			{
				setter(arg, weight);
			}
		}
	}
}
