
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class Answer : UdonSharpBehaviour
{
    public Transform targetPosition;
    public void Update()
    {
        Networking.LocalPlayer.TeleportTo(targetPosition.position,
                                         targetPosition.rotation,
                                         VRC_SceneDescriptor.SpawnOrientation.Default,
                                         false);
    }
}
