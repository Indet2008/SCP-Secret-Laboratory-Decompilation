using System;
using Mirror;
using UnityEngine;
using Utils.Networking;

namespace Hints
{
	public abstract class Hint : DisplayableObject<SharedHintData>
	{
		private Action<Hint> _destroyStrategy;

		private Action<Hint, float> _updateStateStrategy;

		private HintEffect[] _effects;

		public float StartTime { get; private set; }

		protected HintParameter[] Parameters { get; private set; }

		private static void DestroyParameters(Hint self)
		{
			HintParameter[] parameters = self.Parameters;
			for (int i = 0; i < parameters.Length; i++)
			{
				parameters[i].Dispose();
			}
		}

		private static void DestroyEffects(Hint self)
		{
			HintEffect[] effects = self._effects;
			for (int i = 0; i < effects.Length; i++)
			{
				effects[i]?.Dispose();
			}
		}

		private static void UpdateParameters(Hint self, float progress)
		{
			bool flag = false;
			HintParameter[] parameters = self.Parameters;
			for (int i = 0; i < parameters.Length; i++)
			{
				flag |= parameters[i].Update(progress);
			}
			if (flag)
			{
				self.Data.Textbox.text = self.UpdateContent(progress);
			}
		}

		private static void UpdateEffects(Hint self, float progress)
		{
			for (int i = 0; i < self._effects.Length; i++)
			{
				HintEffect hintEffect = self._effects[i];
				if (hintEffect != null && (hintEffect.Awoken || hintEffect.TryAwake(self.Data, progress)) && !(hintEffect.Update(progress) < 1f))
				{
					hintEffect.Dispose();
					self._effects[i] = null;
				}
			}
		}

		protected Hint(HintParameter[] parameters, HintEffect[] effects, float durationScalar = 1f)
			: base(durationScalar)
		{
			_effects = effects;
			Parameters = parameters;
		}

		public override void Deserialize(NetworkReader reader)
		{
			base.Deserialize(reader);
			_effects = reader.ReadHintEffectArray();
			Parameters = reader.ReadHintParameterArray();
		}

		public override void Serialize(NetworkWriter writer)
		{
			base.Serialize(writer);
			writer.WriteHintEffectArray(_effects);
			writer.WriteHintParameterArray(Parameters);
		}

		protected abstract string UpdateContent(float progress);

		protected override void Start()
		{
			StartTime = Time.time;
			if (Parameters == null || Parameters.Length == 0)
			{
				// The original only evaluates the content here; hints without parameters
				// would otherwise never write their text, so it is applied once.
				Data.Textbox.text = UpdateContent(0f);
			}
			if (Parameters != null)
			{
				_destroyStrategy = (Action<Hint>)Delegate.Combine(_destroyStrategy, new Action<Hint>(DestroyParameters));
				_updateStateStrategy = (Action<Hint, float>)Delegate.Combine(_updateStateStrategy, new Action<Hint, float>(UpdateParameters));
				HintParameter[] parameters = Parameters;
				for (int i = 0; i < parameters.Length; i++)
				{
					parameters[i].Awake(Data);
				}
			}
			if (_effects != null)
			{
				_destroyStrategy = (Action<Hint>)Delegate.Combine(_destroyStrategy, new Action<Hint>(DestroyEffects));
				_updateStateStrategy = (Action<Hint, float>)Delegate.Combine(_updateStateStrategy, new Action<Hint, float>(UpdateEffects));
			}
		}

		protected override void Destroy()
		{
			_destroyStrategy?.Invoke(this);
		}

		protected override float UpdateProgress(float rawTime)
		{
			return (rawTime - StartTime) / base.DurationScalar;
		}

		protected override void UpdateState(float progress)
		{
			_updateStateStrategy?.Invoke(this, progress);
		}
	}
}
