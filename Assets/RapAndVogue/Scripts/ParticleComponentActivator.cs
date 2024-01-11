
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using UnityEngine.UI;

public class ParticleComponentActivator : UdonSharpBehaviour
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
            target.GetComponent<ParticleSystem>().Play(true);
        }
        else
        {
            target.GetComponent<ParticleSystem>().Stop(true);
        }
        
        
    }
}
