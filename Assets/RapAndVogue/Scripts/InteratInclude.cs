
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class InteratInclude : UdonSharpBehaviour
{
    public GameObject target;
    bool active = true;
    public override void Interact()
    {
        if (!active) 
        {
            target.GetComponent<MeshRenderer>().enabled = true;
            active = true;
        }
        else
        {
            target.GetComponent<MeshRenderer>().enabled = false;
            active = false;
        }
    }
}
