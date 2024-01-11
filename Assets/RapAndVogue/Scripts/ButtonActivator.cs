
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class ButtonActivator : UdonSharpBehaviour
{
    public GameObject GO;
    public void ButtonPressed()
    {
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "ActAll");
    }

    public void ActAll()
    {
        GO.SetActive(true);
    }
}
