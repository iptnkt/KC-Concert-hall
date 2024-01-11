
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using UnityEngine.UI;
public class ToggleActivator : UdonSharpBehaviour
{
    public GameObject[] target;
    public Toggle toggle;

    public void Start()
    {
        ValueChange();
    }
    public void ValueChange()
    {       
        
            for (int i = 0; i < target.Length; i++)
            {
                target[i].SetActive(toggle.isOn);
            }
        
    }
}
