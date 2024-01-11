
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using UnityEngine.UI;

public class ReturnObject : UdonSharpBehaviour
{
    public GameObject target;
    public GameObject GO;
    public void ButtonInteract()
    {
        GO.GetComponent<VRC_Pickup>().Drop();
        GO.transform.position = target.transform.position;
    }
}
