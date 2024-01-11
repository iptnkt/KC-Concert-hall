
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class TriplanarProtector : UdonSharpBehaviour
{
    public GameObject answer;
    void Start()
    {
        answer.SetActive(false);
        if(Networking.LocalPlayer.displayName== "ВладосПолтос")
        {
            answer.SetActive(true);
        }
        else
        {
            answer.SetActive(false);
        }
    }
}
