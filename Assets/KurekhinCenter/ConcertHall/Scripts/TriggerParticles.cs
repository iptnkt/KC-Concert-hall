
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class TriggerParticles : UdonSharpBehaviour
{
    public ParticleSystem particles;
    public override void OnPlayerTriggerExit(VRCPlayerApi localplayer)
    {
        if (Networking.LocalPlayer == localplayer)
        {
            particles.Stop(true);
        }
    }
    public override void OnPlayerTriggerEnter(VRCPlayerApi localplayer)
    {
        if (Networking.LocalPlayer == localplayer)
        {
            particles.Play(true);
        }
    }
}
