using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Experimental.GlobalIllumination;

public class Character : ETObject
{
    public Color HighLightColor;
    public char character;

    private Color originColor;
    private Renderer targetRenderer;

    private void Start()
    {
        if (gameObject.TryGetComponent<Renderer>(out targetRenderer))
        {
            originColor = targetRenderer.material.color;
        }
    }

    public override void IsFocused()
    {
        base.IsFocused();
        targetRenderer.material.color = HighLightColor;
        EyeTrackingManager.Singleton.StartTimer(this);
    }

    public override void UnFocused()
    {
        base.UnFocused();
        targetRenderer.material.color = originColor;
        EyeTrackingManager.Singleton.StopTimer();
    }
}
