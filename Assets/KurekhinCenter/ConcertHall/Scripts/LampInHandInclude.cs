
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class LampInHandInclude : UdonSharpBehaviour
{
    [UdonSynced]
    private bool syncedValue;
    private bool deserializing;
    private bool lampState;
    private VRCPlayerApi localPlayer;

    public Material darkWire;
    public Material lightWire;
    public GameObject partSys;

    private void Start()
    {
        //dropDown = transform.GetComponent<Dropdown>();
        localPlayer = Networking.LocalPlayer;
        syncedValue = lampState;
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


    public override void OnPickup()
    {
        lampState = true;
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "SyncPickup");

    }
    public override void OnDrop()
    {
        lampState = false;
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "SyncDrop");

    }
    public void SyncPickup()
    {
        /*
        if (deserializing)
            return;
        if (!Networking.IsOwner(gameObject))
            Networking.SetOwner(localPlayer, gameObject);

    */
        var mat = this.gameObject.GetComponent<Renderer>().materials;
        mat[3] = lightWire;

        this.gameObject.GetComponent<Renderer>().materials = mat;

        partSys.SetActive(true); 

        /*
        syncedValue = lampState;
        RequestSerialization();
        */
    }
    public void SyncDrop()
    {
        var mat = this.gameObject.GetComponent<Renderer>().materials;
        mat[3] = darkWire;

        this.gameObject.GetComponent<Renderer>().materials = mat;

        partSys.SetActive(false);
    }
}
 