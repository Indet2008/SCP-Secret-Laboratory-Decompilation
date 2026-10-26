using System;
using System.Collections.Generic;
using UnityEngine;

namespace VoiceChat.Networking
{
	public class PlaybackBuffer : IDisposable
	{
		private static readonly Dictionary<int, Queue<float[]>> PoolsOfSize = new Dictionary<int, Queue<float[]>>();

		private static float[] _organizerArr;

		private static float _organizerSize;

		private readonly int _bufferSize;

		private readonly bool _endless;

		public long ReadHead;

		public long WriteHead;

		public readonly float[] Buffer;

		public int Length => (int)(WriteHead - ReadHead);

		public PlaybackBuffer(int capacity = 24000, bool endlessTapeMode = false)
		{
			_bufferSize = capacity;
			Buffer = ((PoolsOfSize.TryGetValue(capacity, out var value) && value.TryDequeue(out var result)) ? result : new float[_bufferSize]);
			_endless = endlessTapeMode;
			ReadHead = 0L;
			WriteHead = 0L;
		}

		public void Write(float[] f, int length, int sourceIndex)
		{
			long num = WriteHead + length - ReadHead - _bufferSize;
			if (num > 0)
			{
				if (_endless)
				{
					ReadHead += num;
				}
				else
				{
					Clear();
				}
			}
			long num2 = HeadToIndex(WriteHead);
			long num3 = _bufferSize - num2 - length;
			if (num3 >= 0)
			{
				Array.Copy(f, sourceIndex, Buffer, num2, length);
			}
			else
			{
				long num4 = length + num3;
				Array.Copy(f, sourceIndex, Buffer, num2, num4);
				Array.Copy(f, num4 + sourceIndex, Buffer, 0L, -num3);
			}
			WriteHead += length;
		}

		public void Write(float[] f, int length)
		{
			Write(f, length, 0);
		}

		public void Write(float f)
		{
			if (WriteHead >= ReadHead + _bufferSize)
			{
				Clear();
			}
			Buffer[HeadToIndex(WriteHead++)] = f;
		}

		public float Read()
		{
			if (ReadHead < WriteHead)
			{
				return Buffer[HeadToIndex(ReadHead++)];
			}
			return 0f;
		}

		public void ReadTo(float[] arr, long readLength, long destinationIndex = 0L)
		{
			Array.Copy(Buffer, HeadToIndex(ReadHead), arr, destinationIndex, readLength);
			ReadHead += readLength;
		}

		public void Clear()
		{
			ReadHead = 0L;
			WriteHead = 0L;
		}

		public void Reorganize()
		{
			if (ReadHead == 0L)
			{
				return;
			}
			int length = Length;
			if (length == 0)
			{
				Clear();
				return;
			}
			if ((float)length > _organizerSize)
			{
				_organizerArr = new float[length];
				_organizerSize = length;
			}
			long num = HeadToIndex(ReadHead);
			long num2 = _bufferSize - num;
			if (num2 >= length)
			{
				Array.Copy(Buffer, num, _organizerArr, 0L, length);
			}
			else
			{
				Array.Copy(Buffer, num, _organizerArr, 0L, num2);
				Array.Copy(Buffer, num + num2 - _bufferSize, _organizerArr, num2, length - num2);
			}
			Array.Copy(_organizerArr, Buffer, length);
			ReadHead = 0L;
			WriteHead = length;
		}

		public int AddDelay(int samples, bool force = false)
		{
			if (!force)
			{
				samples = Mathf.Min(Mathf.Abs(samples), _bufferSize - Length);
			}
			for (int i = 0; i < samples; i++)
			{
				Buffer[HeadToIndex(--ReadHead)] = 0f;
			}
			return samples;
		}

		public long SyncWith(int bufferLength, int delay = 0)
		{
			long num = Length - bufferLength - delay;
			if (num >= 0)
			{
				ReadHead += num;
			}
			else
			{
				AddDelay((int)(-num), force: true);
			}
			return num;
		}

		public long HeadToIndex(long headPosition)
		{
			return (headPosition % _bufferSize + _bufferSize) % _bufferSize;
		}

		public void Dispose()
		{
			PoolsOfSize.GetOrAddNew(_bufferSize).Enqueue(Buffer);
		}
	}
}
