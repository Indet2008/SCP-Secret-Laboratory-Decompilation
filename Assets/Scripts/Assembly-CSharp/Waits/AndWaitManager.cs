using System.Linq;
using MEC;

namespace Waits
{
	public class AndWaitManager : UntilWaitManager
	{
		protected override bool KeepRunning()
		{
			return waitHandles.All((CoroutineHandle x) => x.IsRunning);
		}
	}
}
