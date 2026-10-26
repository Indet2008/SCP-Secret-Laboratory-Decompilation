using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine;

public static class DebugLog
{
	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void Log(string text)
	{
		UnityEngine.Debug.Log(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void Log(object text)
	{
		UnityEngine.Debug.Log(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void LogWarning(string text)
	{
		UnityEngine.Debug.LogWarning(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void LogWarning(object text)
	{
		UnityEngine.Debug.LogWarning(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void LogError(string text)
	{
		UnityEngine.Debug.LogError(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void LogError(object text)
	{
		UnityEngine.Debug.LogError(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void LogException(Exception exception)
	{
		UnityEngine.Debug.LogException(exception);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Conditional("UNITY_EDITOR")]
	public static void LogEditor(string text)
	{
		UnityEngine.Debug.Log(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Conditional("UNITY_EDITOR")]
	public static void LogEditor(object text)
	{
		UnityEngine.Debug.Log(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Conditional("UNITY_EDITOR")]
	public static void LogWarningEditor(string text)
	{
		UnityEngine.Debug.LogWarning(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Conditional("UNITY_EDITOR")]
	public static void LogWarningEditor(object text)
	{
		UnityEngine.Debug.LogWarning(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Conditional("UNITY_EDITOR")]
	public static void LogErrorEditor(string text)
	{
		UnityEngine.Debug.LogError(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Conditional("UNITY_EDITOR")]
	public static void LogErrorEditor(object text)
	{
		UnityEngine.Debug.LogError(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Conditional("UNITY_EDITOR")]
	public static void LogExceptionEditor(Exception exception)
	{
		UnityEngine.Debug.LogException(exception);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void LogBuild(string text)
	{
		UnityEngine.Debug.Log(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void LogBuild(object text)
	{
		UnityEngine.Debug.Log(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void LogWarningBuild(string text)
	{
		UnityEngine.Debug.LogWarning(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void LogWarningBuild(object text)
	{
		UnityEngine.Debug.LogWarning(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void LogErrorBuild(string text)
	{
		UnityEngine.Debug.LogError(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void LogErrorBuild(object text)
	{
		UnityEngine.Debug.LogError(text);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static void LogExceptionBuild(Exception exception)
	{
		UnityEngine.Debug.LogException(exception);
	}
}
