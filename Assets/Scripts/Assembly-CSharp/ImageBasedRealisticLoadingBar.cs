using UnityEngine;
using UnityEngine.UI;

public class ImageBasedRealisticLoadingBar : MonoBehaviour
{
	private RealisticLoadingBar _bar;

	[SerializeField]
	private float _targetTime;

	[SerializeField]
	private float _stepVar;

	[SerializeField]
	private float _tickVar;

	[SerializeField]
	private int _minNumOfSteps;

	[SerializeField]
	private int _maxNumOfSteps;

	[SerializeField]
	private Image _targetImage;

	[SerializeField]
	private float _smoothing;

	private void OnEnable()
	{
		_targetImage.fillAmount = 0f;
		_bar = new RealisticLoadingBar(_targetTime, Random.Range(_minNumOfSteps, _maxNumOfSteps + 1), _stepVar, _tickVar);
	}

	private void Update()
	{
		_targetImage.fillAmount = Mathf.Lerp(_targetImage.fillAmount, _bar.Progress, Time.deltaTime * _smoothing);
	}
}
