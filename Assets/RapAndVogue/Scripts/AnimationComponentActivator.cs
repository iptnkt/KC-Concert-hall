
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using UnityEngine.UI;

public class AnimationComponentActivator : UdonSharpBehaviour
{
    public GameObject target;
    public Toggle toggle;

    public void Start()
    {
        ValueChange();
    }
    public void ValueChange()
    {
        

        if (toggle.isOn)
        {
            target.GetComponent<Animator>().enabled = true ;
        }
        else
        {
            target.GetComponent<Animator>().enabled = false; 
        }
    }
}