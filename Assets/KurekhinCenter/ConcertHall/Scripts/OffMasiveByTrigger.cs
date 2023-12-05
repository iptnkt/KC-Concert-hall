
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class OffMasiveByTrigger : UdonSharpBehaviour
{
    public GameObject[] targetObject;
    public override void OnPlayerTriggerEnter(VRCPlayerApi player)
    {
        if (Networking.LocalPlayer != player) return;
        for (int i = 0; i < targetObject.Length; i++)
        {
            targetObject[i].SetActive(true);
        }
    }
    public override void OnPlayerTriggerExit(VRCPlayerApi player)
    {
        if (Networking.LocalPlayer != player) return;
        for (int i = 0; i < targetObject.Length; i++)
        {
            targetObject[i].SetActive(false);
        }
    }
}
