
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class TeslaCoilLamp : UdonSharpBehaviour
{
    public Material lightState;
    public Material darkState;
    public GameObject partSys;
    public int materialIndex;
    public void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.name == "ParticlesTrigger")
        {
            var mat = this.gameObject.GetComponent<Renderer>().materials;
            mat[materialIndex] = lightState; 

            this.gameObject.GetComponent<Renderer>().materials = mat;

            if (partSys != null)
            {
                partSys.SetActive(true);
            }
        }
    }

    public void OnTriggerExit(Collider other)
    {
        if (other.gameObject.name == "ParticlesTrigger")
        {
            var mat = this.gameObject.GetComponent<Renderer>().materials;
            mat[materialIndex] = darkState;

            this.gameObject.GetComponent<Renderer>().materials = mat;

            if (partSys != null)
            {
                partSys.SetActive(false); 
            }
        }
    }
}