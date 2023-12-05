
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class ContainerToShelving : UdonSharpBehaviour
{
    public string colliderName;

    private void Start()
    {
        Material[] mats = this.GetComponent<Renderer>().materials;
        mats[1].SetFloat("_Emission", 0);
        this.GetComponent<Renderer>().materials = mats;
    }
    
    public void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.name == colliderName)
        {
            //this.GetComponent<Material>().SetFloat("_Emission", 10);
            Material[] mats = this.GetComponent<Renderer>().materials;
            mats[1].SetFloat("_Emission", 10);
            this.GetComponent<Renderer>().materials = mats;
        }
    }
    public void OnTriggerExit(Collider other)
    {
        if (other.gameObject.name == colliderName)
        {
            Material[] mats = this.GetComponent<Renderer>().materials;
            mats[1].SetFloat("_Emission", 0);
            this.GetComponent<Renderer>().materials = mats;

        }
    }
}
