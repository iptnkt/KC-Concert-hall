
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using UnityEngine.UI;

public class PigeonContol : UdonSharpBehaviour
{
    public Dropdown DDValue;
    public Animator pigeonAnimator;
    public void ValueChange()
    {
        switch (DDValue.value)
        {
            case 0:
                pigeonAnimator.Play("Idle");
                break;
            case 1:
                pigeonAnimator.Play("Slow");
                break;
            case 2:
                pigeonAnimator.Play("Fast");
                break;
            default:
                break;
        }
    }
}
