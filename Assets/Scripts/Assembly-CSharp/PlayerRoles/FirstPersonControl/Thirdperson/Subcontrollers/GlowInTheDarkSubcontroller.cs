using System;
using MapGeneration;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers
{
	public class GlowInTheDarkSubcontroller : SubcontrollerBehaviour
	{
		[Serializable]
		private class TargetRenderer
		{
			public Renderer[] Targets;

			[ColorUsage(false, true)]
			public Color DarkenedColor;

			[ColorUsage(false, true)]
			public Color NormalColor;

			public string PropertyName;

			private bool _everSetUp;

			private int _hash;

			private MaterialPropertyBlock _propertyBlock;

			public void Set(bool darkened)
			{
				if (!_everSetUp)
				{
					_hash = Shader.PropertyToID(PropertyName);
					_propertyBlock = new MaterialPropertyBlock();
					Targets[0].GetPropertyBlock(_propertyBlock);
					_everSetUp = true;
				}
				_propertyBlock.SetColor(_hash, darkened ? DarkenedColor : NormalColor);
				Renderer[] targets = Targets;
				for (int i = 0; i < targets.Length; i++)
				{
					targets[i].SetPropertyBlock(_propertyBlock);
				}
			}
		}

		private enum ForceCondition
		{
			NeverForce = 0,
			ForceWhenFriendly = 1,
			ForceWhenEnemy = 2
		}

		private enum ForceResult
		{
			ForceDarkened = 0,
			ForceNormal = 1
		}

		[SerializeField]
		private TargetRenderer[] _targetRenderers;

		[SerializeField]
		private ForceCondition _forceCondition;

		[SerializeField]
		private ForceResult _resultWhenConditionMet;

		private bool? _prevDarkened;

		private bool IsAtBlackedOutRoom
		{
			get
			{
				if (!base.OwnerHub.TryGetLastKnownRoom(out var room))
				{
					return false;
				}
				Vector3 position = base.Model.LastRole.FpcModule.Position;
				return RoomLightController.IsInDarkenedRoom(room, position);
			}
		}

		private bool IsEnemyToPov
		{
			get
			{
				if (ReferenceHub.TryGetPovHub(out var hub))
				{
					return HitboxIdentity.IsEnemy(hub, base.OwnerHub);
				}
				return false;
			}
		}

		private void LateUpdate()
		{
			if ((base.HasCuller && base.Culler.IsCulled) || !base.HasOwner)
			{
				return;
			}
			bool flag;
			switch (_forceCondition)
			{
			case ForceCondition.ForceWhenFriendly:
			{
				bool conditionMet = !IsEnemyToPov;
				flag = GetDarkenedConditionally(conditionMet);
				break;
			}
			case ForceCondition.ForceWhenEnemy:
				flag = GetDarkenedConditionally(IsEnemyToPov);
				break;
			default:
				flag = IsAtBlackedOutRoom;
				break;
			}
			if (flag != _prevDarkened)
			{
				TargetRenderer[] targetRenderers = _targetRenderers;
				for (int i = 0; i < targetRenderers.Length; i++)
				{
					targetRenderers[i].Set(flag);
				}
				_prevDarkened = flag;
			}
		}

		private void OnValidate()
		{
			_prevDarkened = null;
		}

		private bool GetDarkenedConditionally(bool conditionMet)
		{
			if (!conditionMet)
			{
				return IsAtBlackedOutRoom;
			}
			return _resultWhenConditionMet switch
			{
				ForceResult.ForceNormal => false, 
				ForceResult.ForceDarkened => true, 
				_ => IsAtBlackedOutRoom, 
			};
		}
	}
}
