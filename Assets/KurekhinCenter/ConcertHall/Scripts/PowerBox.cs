
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class PowerBox : UdonSharpBehaviour
{
    public ParticleSystem particles;
    public AudioSource audioLight;
    public GameObject postProc;
    public float vibrationDuration = 10;
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
                Networking.LocalPlayer.PlayHapticEventInHand(VRC_Pickup.PickupHand.Left, vibrationDuration, 1, 2);
                Networking.LocalPlayer.PlayHapticEventInHand(VRC_Pickup.PickupHand.Right, vibrationDuration, 1, 10);
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