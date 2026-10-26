namespace Mirror
{
	[global::UnityEngine.AddComponentMenu("Network/Network Animator")]
	[global::UnityEngine.HelpURL("https://mirror-networking.gitbook.io/docs/components/network-animator")]
	public class NetworkAnimator : global::Mirror.NetworkBehaviour
	{
		[global::UnityEngine.Header("Authority")]
		[global::UnityEngine.Tooltip("Set to true if animations come from owner client,  set to false if animations always come from server")]
		public bool clientAuthority;

		[global::UnityEngine.Serialization.FormerlySerializedAs("m_Animator")]
		[global::UnityEngine.Header("Animator")]
		[global::UnityEngine.Tooltip("Animator that will have parameters synchronized")]
		public global::UnityEngine.Animator animator;

		[global::Mirror.SyncVar(hook = "OnAnimatorSpeedChanged")]
		private float animatorSpeed;

		private float previousSpeed;

		private int[] lastIntParameters;

		private float[] lastFloatParameters;

		private bool[] lastBoolParameters;

		private global::UnityEngine.AnimatorControllerParameter[] parameters;

		private int[] animationHash;

		private int[] transitionHash;

		private float[] layerWeight;

		private double nextSendTime;

		private bool SendMessagesAllowed
		{
			get
			{
				if (base.isServer)
				{
					if (!clientAuthority)
					{
						return true;
					}
					if (base.netIdentity != null && base.netIdentity.connectionToClient == null)
					{
						return true;
					}
				}
				if (base.isOwned)
				{
					return clientAuthority;
				}
				return false;
			}
		}

		public float NetworkanimatorSpeed
		{
			get
			{
				return animatorSpeed;
			}
			[param: global::System.Runtime.InteropServices.In]
			set
			{
				GeneratedSyncVarSetter(value, ref animatorSpeed, 1uL, OnAnimatorSpeedChanged);
			}
		}

		private void Awake()
		{
			parameters = global::System.Linq.Enumerable.ToArray(global::System.Linq.Enumerable.Where(animator.parameters, (global::UnityEngine.AnimatorControllerParameter par) => !animator.IsParameterControlledByCurve(par.nameHash)));
			lastIntParameters = new int[parameters.Length];
			lastFloatParameters = new float[parameters.Length];
			lastBoolParameters = new bool[parameters.Length];
			animationHash = new int[animator.layerCount];
			transitionHash = new int[animator.layerCount];
			layerWeight = new float[animator.layerCount];
		}

		private void FixedUpdate()
		{
			if (!SendMessagesAllowed || !animator.enabled)
			{
				return;
			}
			CheckSendRate();
			for (int i = 0; i < animator.layerCount; i++)
			{
				if (CheckAnimStateChanged(out var stateHash, out var normalizedTime, i))
				{
					using global::Mirror.NetworkWriterPooled networkWriterPooled = global::Mirror.NetworkWriterPool.Get();
					WriteParameters(networkWriterPooled);
					SendAnimationMessage(stateHash, normalizedTime, i, layerWeight[i], networkWriterPooled.ToArray());
				}
			}
			CheckSpeed();
		}

		private void CheckSpeed()
		{
			float speed = animator.speed;
			if (global::UnityEngine.Mathf.Abs(previousSpeed - speed) > 0.001f)
			{
				previousSpeed = speed;
				if (base.isServer)
				{
					NetworkanimatorSpeed = speed;
				}
				else if (base.isClient)
				{
					CmdSetAnimatorSpeed(speed);
				}
			}
		}

		private void OnAnimatorSpeedChanged(float _, float value)
		{
			if (!base.isServer && (!base.isOwned || !clientAuthority))
			{
				animator.speed = value;
			}
		}

		private bool CheckAnimStateChanged(out int stateHash, out float normalizedTime, int layerId)
		{
			bool result = false;
			stateHash = 0;
			normalizedTime = 0f;
			float num = animator.GetLayerWeight(layerId);
			if (global::UnityEngine.Mathf.Abs(num - layerWeight[layerId]) > 0.001f)
			{
				layerWeight[layerId] = num;
				result = true;
			}
			if (animator.IsInTransition(layerId))
			{
				global::UnityEngine.AnimatorTransitionInfo animatorTransitionInfo = animator.GetAnimatorTransitionInfo(layerId);
				if (animatorTransitionInfo.fullPathHash != transitionHash[layerId])
				{
					transitionHash[layerId] = animatorTransitionInfo.fullPathHash;
					animationHash[layerId] = 0;
					return true;
				}
				return result;
			}
			global::UnityEngine.AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(layerId);
			if (currentAnimatorStateInfo.fullPathHash != animationHash[layerId])
			{
				if (animationHash[layerId] != 0)
				{
					stateHash = currentAnimatorStateInfo.fullPathHash;
					normalizedTime = currentAnimatorStateInfo.normalizedTime;
				}
				transitionHash[layerId] = 0;
				animationHash[layerId] = currentAnimatorStateInfo.fullPathHash;
				return true;
			}
			return result;
		}

		private void CheckSendRate()
		{
			double localTime = global::Mirror.NetworkTime.localTime;
			if (!SendMessagesAllowed || !(syncInterval >= 0f) || !(localTime > nextSendTime))
			{
				return;
			}
			nextSendTime = localTime + (double)syncInterval;
			using global::Mirror.NetworkWriterPooled networkWriterPooled = global::Mirror.NetworkWriterPool.Get();
			if (WriteParameters(networkWriterPooled))
			{
				SendAnimationParametersMessage(networkWriterPooled.ToArray());
			}
		}

		private void SendAnimationMessage(int stateHash, float normalizedTime, int layerId, float weight, byte[] parameters)
		{
			if (base.isServer)
			{
				RpcOnAnimationClientMessage(stateHash, normalizedTime, layerId, weight, parameters);
			}
			else if (base.isClient)
			{
				CmdOnAnimationServerMessage(stateHash, normalizedTime, layerId, weight, parameters);
			}
		}

		private void SendAnimationParametersMessage(byte[] parameters)
		{
			if (base.isServer)
			{
				RpcOnAnimationParametersClientMessage(parameters);
			}
			else if (base.isClient)
			{
				CmdOnAnimationParametersServerMessage(parameters);
			}
		}

		private void HandleAnimMsg(int stateHash, float normalizedTime, int layerId, float weight, global::Mirror.NetworkReader reader)
		{
			if (!base.isOwned || !clientAuthority)
			{
				if (stateHash != 0 && animator.enabled)
				{
					animator.Play(stateHash, layerId, normalizedTime);
				}
				animator.SetLayerWeight(layerId, weight);
				ReadParameters(reader);
			}
		}

		private void HandleAnimParamsMsg(global::Mirror.NetworkReader reader)
		{
			if (!base.isOwned || !clientAuthority)
			{
				ReadParameters(reader);
			}
		}

		private void HandleAnimTriggerMsg(int hash)
		{
			if (animator.enabled)
			{
				animator.SetTrigger(hash);
			}
		}

		private void HandleAnimResetTriggerMsg(int hash)
		{
			if (animator.enabled)
			{
				animator.ResetTrigger(hash);
			}
		}

		private ulong NextDirtyBits()
		{
			ulong num = 0uL;
			for (int i = 0; i < parameters.Length; i++)
			{
				global::UnityEngine.AnimatorControllerParameter animatorControllerParameter = parameters[i];
				bool flag = false;
				if (animatorControllerParameter.type == global::UnityEngine.AnimatorControllerParameterType.Int)
				{
					int integer = animator.GetInteger(animatorControllerParameter.nameHash);
					flag = integer != lastIntParameters[i];
					if (flag)
					{
						lastIntParameters[i] = integer;
					}
				}
				else if (animatorControllerParameter.type == global::UnityEngine.AnimatorControllerParameterType.Float)
				{
					float num2 = animator.GetFloat(animatorControllerParameter.nameHash);
					flag = global::UnityEngine.Mathf.Abs(num2 - lastFloatParameters[i]) > 0.001f;
					if (flag)
					{
						lastFloatParameters[i] = num2;
					}
				}
				else if (animatorControllerParameter.type == global::UnityEngine.AnimatorControllerParameterType.Bool)
				{
					bool flag2 = animator.GetBool(animatorControllerParameter.nameHash);
					flag = flag2 != lastBoolParameters[i];
					if (flag)
					{
						lastBoolParameters[i] = flag2;
					}
				}
				if (flag)
				{
					num |= (ulong)(1L << i);
				}
			}
			return num;
		}

		private bool WriteParameters(global::Mirror.NetworkWriter writer, bool forceAll = false)
		{
			ulong num = (forceAll ? ulong.MaxValue : NextDirtyBits());
			writer.WriteULong(num);
			for (int i = 0; i < parameters.Length; i++)
			{
				if ((num & (ulong)(1L << i)) != 0L)
				{
					global::UnityEngine.AnimatorControllerParameter animatorControllerParameter = parameters[i];
					if (animatorControllerParameter.type == global::UnityEngine.AnimatorControllerParameterType.Int)
					{
						int integer = animator.GetInteger(animatorControllerParameter.nameHash);
						writer.WriteInt(integer);
					}
					else if (animatorControllerParameter.type == global::UnityEngine.AnimatorControllerParameterType.Float)
					{
						float value = animator.GetFloat(animatorControllerParameter.nameHash);
						writer.WriteFloat(value);
					}
					else if (animatorControllerParameter.type == global::UnityEngine.AnimatorControllerParameterType.Bool)
					{
						bool value2 = animator.GetBool(animatorControllerParameter.nameHash);
						writer.WriteBool(value2);
					}
				}
			}
			return num != 0;
		}

		private void ReadParameters(global::Mirror.NetworkReader reader)
		{
			bool flag = animator.enabled;
			ulong num = reader.ReadULong();
			for (int i = 0; i < parameters.Length; i++)
			{
				if ((num & (ulong)(1L << i)) == 0L)
				{
					continue;
				}
				global::UnityEngine.AnimatorControllerParameter animatorControllerParameter = parameters[i];
				if (animatorControllerParameter.type == global::UnityEngine.AnimatorControllerParameterType.Int)
				{
					int value = reader.ReadInt();
					if (flag)
					{
						animator.SetInteger(animatorControllerParameter.nameHash, value);
					}
				}
				else if (animatorControllerParameter.type == global::UnityEngine.AnimatorControllerParameterType.Float)
				{
					float value2 = reader.ReadFloat();
					if (flag)
					{
						animator.SetFloat(animatorControllerParameter.nameHash, value2);
					}
				}
				else if (animatorControllerParameter.type == global::UnityEngine.AnimatorControllerParameterType.Bool)
				{
					bool value3 = reader.ReadBool();
					if (flag)
					{
						animator.SetBool(animatorControllerParameter.nameHash, value3);
					}
				}
			}
		}

		public override void OnSerialize(global::Mirror.NetworkWriter writer, bool initialState)
		{
			base.OnSerialize(writer, initialState);
			if (!initialState)
			{
				return;
			}
			for (int i = 0; i < animator.layerCount; i++)
			{
				if (animator.IsInTransition(i))
				{
					global::UnityEngine.AnimatorStateInfo nextAnimatorStateInfo = animator.GetNextAnimatorStateInfo(i);
					writer.WriteInt(nextAnimatorStateInfo.fullPathHash);
					writer.WriteFloat(nextAnimatorStateInfo.normalizedTime);
				}
				else
				{
					global::UnityEngine.AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(i);
					writer.WriteInt(currentAnimatorStateInfo.fullPathHash);
					writer.WriteFloat(currentAnimatorStateInfo.normalizedTime);
				}
				writer.WriteFloat(animator.GetLayerWeight(i));
			}
			WriteParameters(writer, initialState);
		}

		public override void OnDeserialize(global::Mirror.NetworkReader reader, bool initialState)
		{
			base.OnDeserialize(reader, initialState);
			if (initialState)
			{
				for (int i = 0; i < animator.layerCount; i++)
				{
					int stateNameHash = reader.ReadInt();
					float normalizedTime = reader.ReadFloat();
					animator.SetLayerWeight(i, reader.ReadFloat());
					animator.Play(stateNameHash, i, normalizedTime);
				}
				ReadParameters(reader);
			}
		}

		public void SetTrigger(string triggerName)
		{
			SetTrigger(global::UnityEngine.Animator.StringToHash(triggerName));
		}

		public void SetTrigger(int hash)
		{
			if (clientAuthority)
			{
				if (!base.isClient)
				{
					global::UnityEngine.Debug.LogWarning("Tried to set animation in the server for a client-controlled animator");
					return;
				}
				if (!base.isOwned)
				{
					global::UnityEngine.Debug.LogWarning("Only the client with authority can set animations");
					return;
				}
				if (base.isClient)
				{
					CmdOnAnimationTriggerServerMessage(hash);
				}
				HandleAnimTriggerMsg(hash);
			}
			else if (!base.isServer)
			{
				global::UnityEngine.Debug.LogWarning("Tried to set animation in the client for a server-controlled animator");
			}
			else
			{
				HandleAnimTriggerMsg(hash);
				RpcOnAnimationTriggerClientMessage(hash);
			}
		}

		public void ResetTrigger(string triggerName)
		{
			ResetTrigger(global::UnityEngine.Animator.StringToHash(triggerName));
		}

		public void ResetTrigger(int hash)
		{
			if (clientAuthority)
			{
				if (!base.isClient)
				{
					global::UnityEngine.Debug.LogWarning("Tried to reset animation in the server for a client-controlled animator");
					return;
				}
				if (!base.isOwned)
				{
					global::UnityEngine.Debug.LogWarning("Only the client with authority can reset animations");
					return;
				}
				if (base.isClient)
				{
					CmdOnAnimationResetTriggerServerMessage(hash);
				}
				HandleAnimResetTriggerMsg(hash);
			}
			else if (!base.isServer)
			{
				global::UnityEngine.Debug.LogWarning("Tried to reset animation in the client for a server-controlled animator");
			}
			else
			{
				HandleAnimResetTriggerMsg(hash);
				RpcOnAnimationResetTriggerClientMessage(hash);
			}
		}

		[global::Mirror.Command]
		private void CmdOnAnimationServerMessage(int stateHash, float normalizedTime, int layerId, float weight, byte[] parameters)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteInt(stateHash);
			writer.WriteFloat(normalizedTime);
			writer.WriteInt(layerId);
			writer.WriteFloat(weight);
			writer.WriteBytesAndSize(parameters);
			SendCommandInternal("System.Void Mirror.NetworkAnimator::CmdOnAnimationServerMessage(System.Int32,System.Single,System.Int32,System.Single,System.Byte[])", -1895293543, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.Command]
		private void CmdOnAnimationParametersServerMessage(byte[] parameters)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteBytesAndSize(parameters);
			SendCommandInternal("System.Void Mirror.NetworkAnimator::CmdOnAnimationParametersServerMessage(System.Byte[])", 1643781219, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.Command]
		private void CmdOnAnimationTriggerServerMessage(int hash)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteInt(hash);
			SendCommandInternal("System.Void Mirror.NetworkAnimator::CmdOnAnimationTriggerServerMessage(System.Int32)", -83157133, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.Command]
		private void CmdOnAnimationResetTriggerServerMessage(int hash)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteInt(hash);
			SendCommandInternal("System.Void Mirror.NetworkAnimator::CmdOnAnimationResetTriggerServerMessage(System.Int32)", 1048911832, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.Command]
		private void CmdSetAnimatorSpeed(float newSpeed)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteFloat(newSpeed);
			SendCommandInternal("System.Void Mirror.NetworkAnimator::CmdSetAnimatorSpeed(System.Single)", -239557092, writer, 0);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.ClientRpc]
		private void RpcOnAnimationClientMessage(int stateHash, float normalizedTime, int layerId, float weight, byte[] parameters)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteInt(stateHash);
			writer.WriteFloat(normalizedTime);
			writer.WriteInt(layerId);
			writer.WriteFloat(weight);
			writer.WriteBytesAndSize(parameters);
			SendRPCInternal("System.Void Mirror.NetworkAnimator::RpcOnAnimationClientMessage(System.Int32,System.Single,System.Int32,System.Single,System.Byte[])", 861100374, writer, 0, includeOwner: true);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.ClientRpc]
		private void RpcOnAnimationParametersClientMessage(byte[] parameters)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteBytesAndSize(parameters);
			SendRPCInternal("System.Void Mirror.NetworkAnimator::RpcOnAnimationParametersClientMessage(System.Byte[])", 123865504, writer, 0, includeOwner: true);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.ClientRpc]
		private void RpcOnAnimationTriggerClientMessage(int hash)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteInt(hash);
			SendRPCInternal("System.Void Mirror.NetworkAnimator::RpcOnAnimationTriggerClientMessage(System.Int32)", -1010933472, writer, 0, includeOwner: true);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		[global::Mirror.ClientRpc]
		private void RpcOnAnimationResetTriggerClientMessage(int hash)
		{
			global::Mirror.NetworkWriterPooled writer = global::Mirror.NetworkWriterPool.Get();
			writer.WriteInt(hash);
			SendRPCInternal("System.Void Mirror.NetworkAnimator::RpcOnAnimationResetTriggerClientMessage(System.Int32)", -1982785477, writer, 0, includeOwner: true);
			global::Mirror.NetworkWriterPool.Return(writer);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_CmdOnAnimationServerMessage__Int32__Single__Int32__Single__Byte_005B_005D(int stateHash, float normalizedTime, int layerId, float weight, byte[] parameters)
		{
			if (!clientAuthority)
			{
				return;
			}
			using global::Mirror.NetworkReaderPooled reader = global::Mirror.NetworkReaderPool.Get(parameters);
			HandleAnimMsg(stateHash, normalizedTime, layerId, weight, reader);
			RpcOnAnimationClientMessage(stateHash, normalizedTime, layerId, weight, parameters);
		}

		protected static void InvokeUserCode_CmdOnAnimationServerMessage__Int32__Single__Int32__Single__Byte_005B_005D(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdOnAnimationServerMessage called on client.");
			}
			else
			{
				((global::Mirror.NetworkAnimator)obj).UserCode_CmdOnAnimationServerMessage__Int32__Single__Int32__Single__Byte_005B_005D(reader.ReadInt(), reader.ReadFloat(), reader.ReadInt(), reader.ReadFloat(), reader.ReadBytesAndSize());
			}
		}

		protected void UserCode_CmdOnAnimationParametersServerMessage__Byte_005B_005D(byte[] parameters)
		{
			if (!clientAuthority)
			{
				return;
			}
			using global::Mirror.NetworkReaderPooled reader = global::Mirror.NetworkReaderPool.Get(parameters);
			HandleAnimParamsMsg(reader);
			RpcOnAnimationParametersClientMessage(parameters);
		}

		protected static void InvokeUserCode_CmdOnAnimationParametersServerMessage__Byte_005B_005D(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdOnAnimationParametersServerMessage called on client.");
			}
			else
			{
				((global::Mirror.NetworkAnimator)obj).UserCode_CmdOnAnimationParametersServerMessage__Byte_005B_005D(reader.ReadBytesAndSize());
			}
		}

		protected void UserCode_CmdOnAnimationTriggerServerMessage__Int32(int hash)
		{
			if (clientAuthority)
			{
				if (!base.isClient || !base.isOwned)
				{
					HandleAnimTriggerMsg(hash);
				}
				RpcOnAnimationTriggerClientMessage(hash);
			}
		}

		protected static void InvokeUserCode_CmdOnAnimationTriggerServerMessage__Int32(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdOnAnimationTriggerServerMessage called on client.");
			}
			else
			{
				((global::Mirror.NetworkAnimator)obj).UserCode_CmdOnAnimationTriggerServerMessage__Int32(reader.ReadInt());
			}
		}

		protected void UserCode_CmdOnAnimationResetTriggerServerMessage__Int32(int hash)
		{
			if (clientAuthority)
			{
				if (!base.isClient || !base.isOwned)
				{
					HandleAnimResetTriggerMsg(hash);
				}
				RpcOnAnimationResetTriggerClientMessage(hash);
			}
		}

		protected static void InvokeUserCode_CmdOnAnimationResetTriggerServerMessage__Int32(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdOnAnimationResetTriggerServerMessage called on client.");
			}
			else
			{
				((global::Mirror.NetworkAnimator)obj).UserCode_CmdOnAnimationResetTriggerServerMessage__Int32(reader.ReadInt());
			}
		}

		protected void UserCode_CmdSetAnimatorSpeed__Single(float newSpeed)
		{
			animator.speed = newSpeed;
			NetworkanimatorSpeed = newSpeed;
		}

		protected static void InvokeUserCode_CmdSetAnimatorSpeed__Single(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.Debug.LogError("Command CmdSetAnimatorSpeed called on client.");
			}
			else
			{
				((global::Mirror.NetworkAnimator)obj).UserCode_CmdSetAnimatorSpeed__Single(reader.ReadFloat());
			}
		}

		protected void UserCode_RpcOnAnimationClientMessage__Int32__Single__Int32__Single__Byte_005B_005D(int stateHash, float normalizedTime, int layerId, float weight, byte[] parameters)
		{
			using global::Mirror.NetworkReaderPooled reader = global::Mirror.NetworkReaderPool.Get(parameters);
			HandleAnimMsg(stateHash, normalizedTime, layerId, weight, reader);
		}

		protected static void InvokeUserCode_RpcOnAnimationClientMessage__Int32__Single__Int32__Single__Byte_005B_005D(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogError("RPC RpcOnAnimationClientMessage called on server.");
			}
			else
			{
				((global::Mirror.NetworkAnimator)obj).UserCode_RpcOnAnimationClientMessage__Int32__Single__Int32__Single__Byte_005B_005D(reader.ReadInt(), reader.ReadFloat(), reader.ReadInt(), reader.ReadFloat(), reader.ReadBytesAndSize());
			}
		}

		protected void UserCode_RpcOnAnimationParametersClientMessage__Byte_005B_005D(byte[] parameters)
		{
			using global::Mirror.NetworkReaderPooled reader = global::Mirror.NetworkReaderPool.Get(parameters);
			HandleAnimParamsMsg(reader);
		}

		protected static void InvokeUserCode_RpcOnAnimationParametersClientMessage__Byte_005B_005D(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogError("RPC RpcOnAnimationParametersClientMessage called on server.");
			}
			else
			{
				((global::Mirror.NetworkAnimator)obj).UserCode_RpcOnAnimationParametersClientMessage__Byte_005B_005D(reader.ReadBytesAndSize());
			}
		}

		protected void UserCode_RpcOnAnimationTriggerClientMessage__Int32(int hash)
		{
			if (!base.isServer && (!clientAuthority || !base.isOwned))
			{
				HandleAnimTriggerMsg(hash);
			}
		}

		protected static void InvokeUserCode_RpcOnAnimationTriggerClientMessage__Int32(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogError("RPC RpcOnAnimationTriggerClientMessage called on server.");
			}
			else
			{
				((global::Mirror.NetworkAnimator)obj).UserCode_RpcOnAnimationTriggerClientMessage__Int32(reader.ReadInt());
			}
		}

		protected void UserCode_RpcOnAnimationResetTriggerClientMessage__Int32(int hash)
		{
			if (!base.isServer && (!clientAuthority || !base.isOwned))
			{
				HandleAnimResetTriggerMsg(hash);
			}
		}

		protected static void InvokeUserCode_RpcOnAnimationResetTriggerClientMessage__Int32(global::Mirror.NetworkBehaviour obj, global::Mirror.NetworkReader reader, global::Mirror.NetworkConnectionToClient senderConnection)
		{
			if (!global::Mirror.NetworkClient.active)
			{
				global::UnityEngine.Debug.LogError("RPC RpcOnAnimationResetTriggerClientMessage called on server.");
			}
			else
			{
				((global::Mirror.NetworkAnimator)obj).UserCode_RpcOnAnimationResetTriggerClientMessage__Int32(reader.ReadInt());
			}
		}

		static NetworkAnimator()
		{
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.NetworkAnimator), "System.Void Mirror.NetworkAnimator::CmdOnAnimationServerMessage(System.Int32,System.Single,System.Int32,System.Single,System.Byte[])", InvokeUserCode_CmdOnAnimationServerMessage__Int32__Single__Int32__Single__Byte_005B_005D, requiresAuthority: true);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.NetworkAnimator), "System.Void Mirror.NetworkAnimator::CmdOnAnimationParametersServerMessage(System.Byte[])", InvokeUserCode_CmdOnAnimationParametersServerMessage__Byte_005B_005D, requiresAuthority: true);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.NetworkAnimator), "System.Void Mirror.NetworkAnimator::CmdOnAnimationTriggerServerMessage(System.Int32)", InvokeUserCode_CmdOnAnimationTriggerServerMessage__Int32, requiresAuthority: true);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.NetworkAnimator), "System.Void Mirror.NetworkAnimator::CmdOnAnimationResetTriggerServerMessage(System.Int32)", InvokeUserCode_CmdOnAnimationResetTriggerServerMessage__Int32, requiresAuthority: true);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterCommand(typeof(global::Mirror.NetworkAnimator), "System.Void Mirror.NetworkAnimator::CmdSetAnimatorSpeed(System.Single)", InvokeUserCode_CmdSetAnimatorSpeed__Single, requiresAuthority: true);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterRpc(typeof(global::Mirror.NetworkAnimator), "System.Void Mirror.NetworkAnimator::RpcOnAnimationClientMessage(System.Int32,System.Single,System.Int32,System.Single,System.Byte[])", InvokeUserCode_RpcOnAnimationClientMessage__Int32__Single__Int32__Single__Byte_005B_005D);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterRpc(typeof(global::Mirror.NetworkAnimator), "System.Void Mirror.NetworkAnimator::RpcOnAnimationParametersClientMessage(System.Byte[])", InvokeUserCode_RpcOnAnimationParametersClientMessage__Byte_005B_005D);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterRpc(typeof(global::Mirror.NetworkAnimator), "System.Void Mirror.NetworkAnimator::RpcOnAnimationTriggerClientMessage(System.Int32)", InvokeUserCode_RpcOnAnimationTriggerClientMessage__Int32);
			global::Mirror.RemoteCalls.RemoteProcedureCalls.RegisterRpc(typeof(global::Mirror.NetworkAnimator), "System.Void Mirror.NetworkAnimator::RpcOnAnimationResetTriggerClientMessage(System.Int32)", InvokeUserCode_RpcOnAnimationResetTriggerClientMessage__Int32);
		}

		protected override void SerializeSyncVars(global::Mirror.NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteFloat(animatorSpeed);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteFloat(animatorSpeed);
			}
		}

		protected override void DeserializeSyncVars(global::Mirror.NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref animatorSpeed, OnAnimatorSpeedChanged, reader.ReadFloat());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref animatorSpeed, OnAnimatorSpeedChanged, reader.ReadFloat());
			}
		}
	}
}
