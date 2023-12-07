
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class SubAnimTrigger : UdonSharpBehaviour
{
    [Header("Event (animTrigger)")]
    public UdonBehaviour targetScript;
    public string eventName;
    public void animTrigger()
    {
        targetScript.SendCustomEvent(eventName);
    }
}
