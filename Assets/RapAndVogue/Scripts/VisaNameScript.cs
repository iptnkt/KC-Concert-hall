
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using UnityEngine.UI;

public class VisaNameScript : UdonSharpBehaviour
{
    public Text nameString;
    public Text randID;
    void Start()
    {
        nameString.text = Networking.LocalPlayer.displayName;
        randID.text = Random.Range(0, 99).ToString();
    }
}
