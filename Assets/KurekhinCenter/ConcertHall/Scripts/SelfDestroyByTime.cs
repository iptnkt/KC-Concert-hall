
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class SelfDestroyByTime : UdonSharpBehaviour
{
    public float timeToDie;
       
    public void Awake()
    {        
        Destroy(gameObject, timeToDie);
        
    }
    public override void OnSpawn()
    {
        Destroy(gameObject, timeToDie);

    }

}
