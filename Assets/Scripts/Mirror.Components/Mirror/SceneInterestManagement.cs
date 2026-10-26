namespace Mirror
{
	[global::UnityEngine.AddComponentMenu("Network/ Interest Management/ Scene/Scene Interest Management")]
	public class SceneInterestManagement : global::Mirror.InterestManagement
	{
		private readonly global::System.Collections.Generic.Dictionary<global::UnityEngine.SceneManagement.Scene, global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity>> sceneObjects = new global::System.Collections.Generic.Dictionary<global::UnityEngine.SceneManagement.Scene, global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity>>();

		private readonly global::System.Collections.Generic.Dictionary<global::Mirror.NetworkIdentity, global::UnityEngine.SceneManagement.Scene> lastObjectScene = new global::System.Collections.Generic.Dictionary<global::Mirror.NetworkIdentity, global::UnityEngine.SceneManagement.Scene>();

		private global::System.Collections.Generic.HashSet<global::UnityEngine.SceneManagement.Scene> dirtyScenes = new global::System.Collections.Generic.HashSet<global::UnityEngine.SceneManagement.Scene>();

		[global::Mirror.ServerCallback]
		public override void OnSpawned(global::Mirror.NetworkIdentity identity)
		{
			if (global::Mirror.NetworkServer.active)
			{
				global::UnityEngine.SceneManagement.Scene scene = identity.gameObject.scene;
				lastObjectScene[identity] = scene;
				if (!sceneObjects.TryGetValue(scene, out var value))
				{
					value = new global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity>();
					sceneObjects.Add(scene, value);
				}
				value.Add(identity);
			}
		}

		[global::Mirror.ServerCallback]
		public override void OnDestroyed(global::Mirror.NetworkIdentity identity)
		{
			if (global::Mirror.NetworkServer.active && lastObjectScene.TryGetValue(identity, out var value))
			{
				lastObjectScene.Remove(identity);
				if (sceneObjects.TryGetValue(value, out var value2) && value2.Remove(identity))
				{
					dirtyScenes.Add(value);
				}
			}
		}

		[global::Mirror.ServerCallback]
		internal void Update()
		{
			if (!global::Mirror.NetworkServer.active)
			{
				return;
			}
			foreach (global::Mirror.NetworkIdentity value2 in global::Mirror.NetworkServer.spawned.Values)
			{
				if (!lastObjectScene.TryGetValue(value2, out var value))
				{
					continue;
				}
				global::UnityEngine.SceneManagement.Scene scene = value2.gameObject.scene;
				if (!(scene == value))
				{
					dirtyScenes.Add(value);
					dirtyScenes.Add(scene);
					sceneObjects[value].Remove(value2);
					lastObjectScene[value2] = scene;
					if (!sceneObjects.ContainsKey(scene))
					{
						sceneObjects.Add(scene, new global::System.Collections.Generic.HashSet<global::Mirror.NetworkIdentity>());
					}
					sceneObjects[scene].Add(value2);
				}
			}
			foreach (global::UnityEngine.SceneManagement.Scene dirtyScene in dirtyScenes)
			{
				RebuildSceneObservers(dirtyScene);
			}
			dirtyScenes.Clear();
		}

		private void RebuildSceneObservers(global::UnityEngine.SceneManagement.Scene scene)
		{
			foreach (global::Mirror.NetworkIdentity item in sceneObjects[scene])
			{
				if (item != null)
				{
					global::Mirror.NetworkServer.RebuildObservers(item, initialize: false);
				}
			}
		}

		public override bool OnCheckObserver(global::Mirror.NetworkIdentity identity, global::Mirror.NetworkConnectionToClient newObserver)
		{
			return identity.gameObject.scene == newObserver.identity.gameObject.scene;
		}

		public override void OnRebuildObservers(global::Mirror.NetworkIdentity identity, global::System.Collections.Generic.HashSet<global::Mirror.NetworkConnectionToClient> newObservers)
		{
			if (!sceneObjects.TryGetValue(identity.gameObject.scene, out var value))
			{
				return;
			}
			foreach (global::Mirror.NetworkIdentity item in value)
			{
				if (item != null && item.connectionToClient != null)
				{
					newObservers.Add(item.connectionToClient);
				}
			}
		}
	}
}
