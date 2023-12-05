
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class PowerBox : UdonSharpBehaviour
{
    public ParticleSystem particles;
    public AudioSource audioLight;
    public GameObject postProc;
    public override void OnPlayerTriggerEnter(VRCPlayerApi localplayer)
    {
        if (Networking.LocalPlayer == localplayer)
        {
            SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "EffectForAll");
            postProc.SetActive(true);
            postProc.GetComponent<Animator>().Play("Die");
            SendCustomEventDelayedSeconds("PowerBoxRespawnPlayer", 3);
            Networking.LocalPlayer.Immobilize(true);
            if (Networking.LocalPlayer.IsUserInVR())
            {
                Networking.LocalPlayer.PlayHapticEventInHand(VRC_Pickup.PickupHand.Left, 1, 1, 1);
                Networking.LocalPlayer.PlayHapticEventInHand(VRC_Pickup.PickupHand.Right, 1, 1, 1);
            }
        }
    }
    public void PowerBoxRespawnPlayer()
    {
        Networking.LocalPlayer.Immobilize(false);
        postProc.SetActive(false);
        Networking.LocalPlayer.Respawn();
    }
    public void EffectForAll()
    {
        particles.Play(true);
        audioLight.Play();
    }
}