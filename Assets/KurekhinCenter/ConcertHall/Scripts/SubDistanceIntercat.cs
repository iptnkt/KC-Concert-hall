
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class SubDistanceIntercat : UdonSharpBehaviour
{
    //public UdonBehaviour target;
    public Lift Target;
    public override void Interact()
    {
        //target.SendCustomEvent("Interact");
        Target.Interact();
    }
}
