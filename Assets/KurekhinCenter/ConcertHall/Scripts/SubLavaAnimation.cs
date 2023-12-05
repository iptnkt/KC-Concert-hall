
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class SubLavaAnimation : UdonSharpBehaviour
{
    
    public RazCatActChanger mainScript;

    public void LavaReadyAnim()
    {
        Debug.Log("Lava anim end");
        mainScript.LavaReady();
    }
}
