
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class IncludeError : UdonSharpBehaviour
{
    public GameObject postProcError;
    public float timeToReanim = 60;
    public RazCatActChanger mainScript;
    public AudioSource rubilnik;
    public AudioSource shutdown;
    public override void Interact()
    {
        
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All,"MassError");
    }
    public void MassError()
    {
        rubilnik.Stop();
        rubilnik.Play();
        this.gameObject.GetComponent<BoxCollider>().enabled = false;
        postProcError.SetActive(true);
        SendCustomEventDelayedSeconds("Reanim", timeToReanim);
        SendCustomEventDelayedSeconds("ShutdownSound", 3);
    }

    public void ShutdownSound() 
    {
        shutdown.Stop();
        shutdown.Play();
    }

    public void ManualReanim()
    {
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "Reanim");
    }
    public void Reanim()
    {
        this.gameObject.GetComponent<BoxCollider>().enabled = true;
        postProcError.SetActive(false);
        mainScript.StartActZero();
    }
}
