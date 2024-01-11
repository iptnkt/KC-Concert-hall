
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using UnityEngine.UI;

public class LightWireScript : UdonSharpBehaviour
{
    public Material mat;
    [ColorUsage(true, true)]
    public Color colorLamp;
    public Toggle includerToggle;
    void Start()
    {
        mat.SetColor("_EmissionColor", Color.black);
    }
    public void ToggleInteract()
    {
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "IncludeAll");
        
    }
    public void IncludeAll()
    {
        if (includerToggle.isOn)
        {
            mat.SetColor("_EmissionColor", colorLamp);
        }
        else
        {
            mat.SetColor("_EmissionColor", Color.black);
        }
    }
}
