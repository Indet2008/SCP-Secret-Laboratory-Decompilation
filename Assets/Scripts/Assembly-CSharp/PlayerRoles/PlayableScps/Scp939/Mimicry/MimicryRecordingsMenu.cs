using System;
using System.Collections.Generic;
using NorthwoodLib.Pools;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class MimicryRecordingsMenu : MimicryMenuBase
	{
		[SerializeField]
		private MimicryRecordingIcon _iconTemplate;

		[SerializeField]
		private RectTransform _iconsParent;

		[SerializeField]
		private float _spacing;

		[SerializeField]
		private float _lerpSpeed;

		[SerializeField]
		private float _dragIconOffset;

		[SerializeField]
		private float _dragPositionOffset;

		private bool _updateNextFrame;

		private MimicryRecorder _recorder;

		private MimicryRecordingIcon[] _instancesUserOrder;

		private MimicryRecordingIcon _draggedInstance;

		private readonly List<MimicryRecordingIcon> _instancesChronological = new List<MimicryRecordingIcon>();

		protected override void Setup(Scp939Role role)
		{
			base.Setup(role);
			role.SubroutineModule.TryGetSubroutine<MimicryRecorder>(out _recorder);
			int maxRecordings = _recorder.MaxRecordings;
			_instancesUserOrder = new MimicryRecordingIcon[maxRecordings];
			for (int i = 0; i < maxRecordings; i++)
			{
				MimicryRecordingIcon mimicryRecordingIcon = UnityEngine.Object.Instantiate(_iconTemplate, _iconsParent);
				mimicryRecordingIcon.IsEmpty = true;
				mimicryRecordingIcon.gameObject.SetActive(value: true);
				_instancesUserOrder[i] = mimicryRecordingIcon;
			}
			UpdateInstancePositions(1f);
			_recorder.OnSavedVoicesModified += OnVoicesModified;
		}

		private void OnDestroy()
		{
			if (!(_recorder == null))
			{
				_recorder.OnSavedVoicesModified -= OnVoicesModified;
			}
		}

		private void OnVoicesModified()
		{
			_updateNextFrame = true;
			if (_recorder.SavedVoices.Count <= _recorder.MaxRecordings)
			{
				return;
			}
			List<int> list = ListPool<int>.Shared.Rent();
			for (int i = 0; i < _recorder.MaxRecordings; i++)
			{
				if (!_instancesUserOrder[i].IsFavorite)
				{
					list.Add(i);
				}
			}
			int num = ((list.Count > 0) ? list.RandomItem() : UnityEngine.Random.Range(0, _recorder.MaxRecordings));
			ListPool<int>.Shared.Return(list);
			_recorder.RemoveVoice(_instancesUserOrder[num].VoiceRecord);
		}

		private bool GetDragData(out int occupiedIndex, out int targetIndex, out float targetHeight)
		{
			occupiedIndex = _instancesUserOrder.IndexOf(_draggedInstance);
			if (occupiedIndex < 0)
			{
				targetIndex = -1;
				targetHeight = -1f;
				return false;
			}
			float num = (RectTransformUtility.ScreenPointToLocalPointInRectangle(_iconsParent, Input.mousePosition, null, out var localPoint) ? (0f - localPoint.y) : 0f);
			targetHeight = num + _dragIconOffset;
			targetIndex = Mathf.CeilToInt((num + _dragPositionOffset) / _spacing) - 1;
			return true;
		}

		private void UpdateInstancePositions(float interpolant)
		{
			bool dragData = GetDragData(out var occupiedIndex, out var targetIndex, out var targetHeight);
			for (int i = 0; i < _instancesUserOrder.Length; i++)
			{
				float num2;
				if (dragData)
				{
					int num = i + GetPositionOffset(i, occupiedIndex, targetIndex);
					num2 = ((i == occupiedIndex) ? targetHeight : (_spacing * (float)num));
				}
				else
				{
					num2 = _spacing * (float)i;
				}
				MimicryRecordingIcon obj = _instancesUserOrder[i];
				obj.Height = Mathf.Lerp(obj.Height, 0f - num2, interpolant);
			}
			if (dragData && !Input.GetKey(KeyCode.Mouse0))
			{
				_draggedInstance = null;
				Array.Sort(_instancesUserOrder, (MimicryRecordingIcon x, MimicryRecordingIcon y) => y.Height.CompareTo(x.Height));
			}
		}

		private int GetPositionOffset(int instanceId, int origin, int target)
		{
			bool flag = instanceId > origin;
			if (target >= origin)
			{
				if (flag && instanceId <= target)
				{
					return -1;
				}
			}
			else if (!flag && instanceId >= target)
			{
				return 1;
			}
			return 0;
		}

		private void AddInstance(int recordingId)
		{
			MimicryRecordingIcon mimicryRecordingIcon = UnityEngine.Object.Instantiate(_iconTemplate, _iconsParent);
			mimicryRecordingIcon.Setup(_recorder, recordingId);
			mimicryRecordingIcon.gameObject.SetActive(value: true);
			_instancesChronological.Add(mimicryRecordingIcon);
			for (int i = 0; i < _recorder.MaxRecordings; i++)
			{
				MimicryRecordingIcon mimicryRecordingIcon2 = _instancesUserOrder[i];
				if (mimicryRecordingIcon2.IsEmpty)
				{
					_instancesUserOrder[i] = mimicryRecordingIcon;
					mimicryRecordingIcon.Height = mimicryRecordingIcon2.Height;
					UnityEngine.Object.Destroy(mimicryRecordingIcon2.gameObject);
					break;
				}
			}
		}

		private void RemoveInstance(MimicryRecordingIcon instance)
		{
			instance.IsEmpty = true;
			_instancesChronological.Remove(instance);
		}

		private void Update()
		{
			UpdateInstancePositions(Time.deltaTime * _lerpSpeed);
			if (!_updateNextFrame)
			{
				return;
			}
			int num = _instancesChronological.Count;
			int count = _recorder.SavedVoices.Count;
			for (int i = 0; i < num; i++)
			{
				MimicryRecordingIcon mimicryRecordingIcon = _instancesChronological[i];
				if (i >= count || mimicryRecordingIcon.VoiceRecord != _recorder.SavedVoices[i].Buffer)
				{
					RemoveInstance(mimicryRecordingIcon);
					num--;
					i--;
				}
			}
			for (int j = num; j < count; j++)
			{
				AddInstance(j);
			}
			_updateNextFrame = false;
		}

		internal void BeginDrag(MimicryRecordingIcon icon)
		{
			_draggedInstance = icon;
		}
	}
}
