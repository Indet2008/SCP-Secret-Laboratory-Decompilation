using System.Collections.Generic;
using Interactables.Interobjects;
using MapGeneration;
using UnityEngine;

namespace RoomDecorations.CableTray
{
	public class CableTrayConnector : MonoBehaviour
	{
		[SerializeField]
		private GameObject _seal;

		[SerializeField]
		private GameObject _passthrough;

		[SerializeField]
		private bool _destroyOpenEnded;

		private IRoomConnector _roomConnector;

		private const float DetectionHorizontalRangeSqr = 0.2f;

		private const float DetectionVerticalRangeAbs = 10f;

		private void Awake()
		{
			_roomConnector = GetComponent<IRoomConnector>();
			if (_roomConnector.RoomsAlreadyRegistered)
			{
				FindConnections();
			}
			else
			{
				_roomConnector.OnRoomsRegistered += FindConnections;
			}
		}

		private void FindConnections()
		{
			CableEndIndicator result2;
			if (TryFindCableEnd(CableEndIndicator.UnconnectedInstances, out var result))
			{
				if (result.OpenEnded && _destroyOpenEnded)
				{
					result.gameObject.SetActive(value: false);
					SetStatus(passthrough: false, seal: false);
				}
				else
				{
					SetStatus(passthrough: false, seal: true);
					Vector3 v = result.GetComponentInParent<RoomIdentifier>().transform.position - base.transform.position;
					_seal.transform.SetPositionAndRotation(result.transform.position, Quaternion.LookRotation(v.NormalizeIgnoreY()));
				}
			}
			else if (TryFindCableEnd(CableEndIndicator.AllInstances, out result2))
			{
				SetStatus(passthrough: true, seal: false);
			}
			else
			{
				SetStatus(passthrough: false, seal: false);
			}
		}

		private void SetStatus(bool passthrough, bool seal)
		{
			if (_seal != null)
			{
				_seal.SetActive(seal);
			}
			if (_passthrough != null)
			{
				_passthrough.SetActive(passthrough);
			}
		}

		private bool TryFindCableEnd(HashSet<CableEndIndicator> src, out CableEndIndicator result)
		{
			Vector3 position = base.transform.position;
			foreach (CableEndIndicator item in src)
			{
				Vector3 v = item.Position - position;
				if (!(v.SqrMagnitudeIgnoreY() > 0.2f) && !(v.MagnitudeOnlyY() > 10f))
				{
					result = item;
					return true;
				}
			}
			result = null;
			return false;
		}
	}
}
