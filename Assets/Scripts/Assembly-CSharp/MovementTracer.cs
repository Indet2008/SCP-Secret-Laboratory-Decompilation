using RelativePositioning;
using UnityEngine;

public class MovementTracer
{
	public byte Clock;

	public readonly RelativePosition[] Positions;

	private readonly byte _size;

	private readonly byte _cooldown;

	private readonly float _tpDis;

	private byte _cooldownTimer;

	public MovementTracer(byte size, byte cooldown, float teleportDistance)
	{
		_size = size;
		Positions = new RelativePosition[size];
		_cooldown = cooldown;
		_tpDis = teleportDistance;
		_cooldownTimer = 0;
	}

	public void Record(Vector3 plyPosition)
	{
		if (_cooldownTimer > 0)
		{
			_cooldownTimer--;
			return;
		}
		if (++Clock >= _size)
		{
			Clock = 0;
		}
		Positions[Clock] = new RelativePosition(plyPosition);
		_cooldownTimer = _cooldown;
	}

	public Bounds GenerateBounds(float time, bool ignoreTeleports)
	{
		int num = Mathf.FloorToInt(time / Time.fixedDeltaTime / (float)(_cooldown + 1));
		if (num <= 0)
		{
			Debug.LogError($"MovementTracer was requested to generate Bounds for the last {time} seconds, but it's too short. Please access PlayerMovementSync.RealModelPosition directly.");
			num = 1;
		}
		else if (num > _size)
		{
			Debug.LogError($"MovementTracer was requested to generate Bounds for the last {time} seconds, but it can't keep track of positions after {((float)(int)_cooldown + 1f) * (float)(int)_size * Time.fixedDeltaTime}");
			num = _size;
		}
		Bounds result = new Bounds(Positions[Clock].Position, Vector3.zero);
		for (int i = 1; i < num; i++)
		{
			int num2 = Clock - i;
			if (num2 < 0)
			{
				num2 += _size - 1;
			}
			RelativePosition relativePosition = Positions[num2];
			using (new WaypointBacktracker(relativePosition.WaypointId, (float)(i * (_cooldown + 1)) * Time.fixedDeltaTime))
			{
				Vector3 position = relativePosition.Position;
				if (!ignoreTeleports && Vector3.Distance(result.ClosestPoint(position), position) > _tpDis)
				{
					break;
				}
				result.Encapsulate(position);
				continue;
			}
		}
		return result;
	}
}
