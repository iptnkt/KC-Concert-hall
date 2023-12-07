
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class LampOnTableIncluder : UdonSharpBehaviour
{
    [UdonSynced]  bool syncedValue;
    private bool lampState;
    public GameObject lamp;
    public GameObject particles;
    public GameObject connector;

    public Material darkWire;
    public Material lightWire;

    private bool deserializing;
    private VRCPlayerApi localPlayer;

    private void Start()
    {
        //dropDown = transform.GetComponent<Dropdown>();
        localPlayer = Networking.LocalPlayer;
        syncedValue = lampState;
        //Interact();
        deserializing = false;

        if (Networking.IsOwner(gameObject) == false)
        {
            Networking.SetOwner(localPlayer, gameObject);
        }
        if (Networking.IsOwner(gameObject) == true)
        {
            RequestSerialization();
        }
    }

    public override void OnDeserialization()
    {
        deserializing = true;
        lampState = syncedValue;
        deserializing = false;
    }
    public override void Interact()
    {
        if (syncedValue)//значение противоположно, toggle
        {            
            lampState = false;
            SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "LampIncludingOff");
        }
        else
        {
            lampState = true;
            SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "LampIncludingON");
        }

        syncedValue = lampState;
        if (Networking.IsOwner(gameObject) == false)
        {
            Networking.SetOwner(localPlayer, gameObject);
        }
        if (Networking.IsOwner(gameObject) == true)
        {
            RequestSerialization();

        }

        Debug.Log("LampInteracted;");
    }
    
    public void LampIncludingON()
    {
        particles.SetActive(true);
        connector.GetComponent<SkinnedMeshRenderer>().SetBlendShapeWeight(0, 100);
        var mat = lamp.gameObject.GetComponent<Renderer>().materials;
        mat[3] = lightWire;

        lamp.gameObject.GetComponent<Renderer>().materials = mat;
    }
    public void LampIncludingOff()
    {
        particles.SetActive(false);
        connector.GetComponent<SkinnedMeshRenderer>().SetBlendShapeWeight(0, 0);
        var mat = lamp.gameObject.GetComponent<Renderer>().materials;
        mat[3] = darkWire;
        lamp.gameObject.GetComponent<Renderer>().materials = mat;
    }
}

