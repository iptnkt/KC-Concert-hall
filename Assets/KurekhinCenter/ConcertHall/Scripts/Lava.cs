
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class Lava : UdonSharpBehaviour
{
    public GameObject flameParticles;
    // public AudioSource audioLight;
    public GameObject postProc;
    public Vector3 diePosition;
    public float scrollSpeed;
    Quaternion dieRotation;
    public Material mat;
    public override void OnPlayerTriggerEnter(VRCPlayerApi localplayer)
    {
        if (Networking.LocalPlayer == localplayer)
        {
            diePosition = Networking.LocalPlayer.GetPosition();
            dieRotation = Networking.LocalPlayer.GetRotation();
            SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "BurnEffectForAll");
            postProc.SetActive(true);
            postProc.GetComponent<Animator>().Play("Die");
            SendCustomEventDelayedSeconds("PowerBoxRespawnPlayer", 3);
            Networking.LocalPlayer.Immobilize(true); 

        }
    }
    public void PowerBoxRespawnPlayer()
    {
        Networking.LocalPlayer.Immobilize(false);
        postProc.SetActive(false);
        Networking.LocalPlayer.Respawn();
    }
    public void BurnEffectForAll()
    {
        
        //UdonBehaviour.Instantiate(flameParticles,diePosition, dieRotation);
           
        
    }

    private void Update()
    {
        mat.SetTextureOffset("_MainTex", new Vector2(Time.time * scrollSpeed, 3));
    }
}
