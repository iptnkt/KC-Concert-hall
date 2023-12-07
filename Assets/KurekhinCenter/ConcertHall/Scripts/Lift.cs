
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class Lift : UdonSharpBehaviour
{
    public Animator anim;

    public bool directionUp;
    public bool arrive;

    private void Start()
    {
        directionUp = true;
        arrive = true;
    }
    public override void Interact()
    {        
        if (!arrive) return;
        

        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All,"LiftMove");
    }
     
    public void LiftMove()
    {
        arrive = false;
        if (directionUp)
        {
            //anim.SetBool("MoveUp", true);
            anim.Play("Up");
            Debug.Log("Lift move Up");
            directionUp = false;

        }
        else
        {
            //anim.SetBool("MoveUp", false);
            anim.Play("Down");
            Debug.Log("Lift move Down");
            directionUp = true;
        }
    }
    public void Arrive()
    {
        arrive = true;
        Debug.Log("Lift arrive");
    }
}
