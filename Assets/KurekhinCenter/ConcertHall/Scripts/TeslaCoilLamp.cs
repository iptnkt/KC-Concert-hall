
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class TeslaCoilLamp : UdonSharpBehaviour
{
    public Material lightWire;
    public Material darkWire;
    public GameObject partSys;
    public void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.name == "ParticlesTrigger")
        {
            var mat = this.gameObject.GetComponent<Renderer>().materials;
            mat[3] = lightWire; 

            this.gameObject.GetComponent<Renderer>().materials = mat;

            partSys.SetActive(true);
        }
    }

    public void OnTriggerExit(Collider other)
    {
        if (other.gameObject.name == "ParticlesTrigger")
        {
            var mat = this.gameObject.GetComponent<Renderer>().materials;
            mat[3] = darkWire;

            this.gameObject.GetComponent<Renderer>().materials = mat;

            partSys.SetActive(false);
        }
    }
}