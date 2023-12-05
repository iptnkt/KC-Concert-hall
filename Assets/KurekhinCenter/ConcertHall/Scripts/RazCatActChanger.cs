﻿
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using UnityEngine.UI;

public class RazCatActChanger : UdonSharpBehaviour
{
    [Header("Items")]
    public GameObject[] actOneItems; //Wires
    public GameObject[] actTwoItems; //Plaets
    public GameObject[] actThreeItems; //Puildings
    public GameObject[] actFourItems; //Melting
    public GameObject Lava; 
    public GameObject[] actFiveItems; //Electro
    public GameObject[] dancerPlace;

    [Header("DancerPlacers")]
    public Transform[] actOneDancerPlaces;
    public Transform[] actTwoDancerPlaces;
    public Transform[] actThreeDancerPlaces;
    public Transform[] actFourDancerPlaces;
    public Transform[] actFiveDancerPlaces;

    [Header("Effects")]
    public GameObject transitPostProc;
    public float timeSwitchOffTransit;
    public ReflectionProbe[] reflProbes;

    //public Material[] containerMaterials;



    public MainAppratController mainController;
    public Animator ceilAnim;
    public Animator wallsAnim;
    [UdonSynced] int lateJoinScena;
    private int curretAction;
    private bool deserializing;
    public Material magmaOffeset;
    public float magmaScrollSpeed;
    public Text test ;



    private void Start()
    {
        ceilAnim.Play("Idle");
        for (int i = 0; i < actOneItems.Length; i++)
        {
            actOneItems[i].SetActive(false);
        }
        for (int i = 0; i < actTwoItems.Length; i++)
        {
            actTwoItems[i].SetActive(false);
        }
        for (int i = 0; i < actThreeItems.Length; i++)
        {
            actThreeItems[i].SetActive(false);
        }

        for (int i = 0; i < actFourItems.Length; i++)
        {
            actFourItems[i].SetActive(false);
        }

        for (int i = 0; i < actFiveItems.Length; i++)
        {
            actFiveItems[i].SetActive(false);
        }
        Lava.gameObject.SetActive(false);

        for (int i = 0; i < reflProbes.Length; i++)
        {
            reflProbes[i].RenderProbe();
        }

        if (Networking.IsOwner(gameObject))
            RequestSerialization();

    }

    public override void OnDeserialization()
    {
        deserializing = true;
        if (curretAction == lateJoinScena)
        {
            deserializing = false;
            return;
        }
        curretAction = lateJoinScena;
        switch (curretAction)
        {
            case 0:
                break;
            case 1:
                StartActOne();
                break;
            case 2:
                StartActTwo();
                break;
            case 3:
                StartActThree();
                break;
            case 4:
                StartActFour();
                break;
            case 5:
                StartActFive();
                break;

        }
        test.text = curretAction.ToString();
        deserializing = false;
    }

    public void PressedButtonOne()
    {
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "StartActOne");
       
        if (deserializing)
            return;
        if (!Networking.IsOwner(gameObject))
            Networking.SetOwner(Networking.LocalPlayer, gameObject);
        lateJoinScena = 1;
        RequestSerialization();

        
    }
    public void PressedButtonTwo()
    {
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "StartActTwo");
        if (deserializing)
            return;
        if (!Networking.IsOwner(gameObject))
            Networking.SetOwner(Networking.LocalPlayer, gameObject);
        lateJoinScena = 2;
        RequestSerialization();

        

    }
    public void PressedButtonThree()
    {
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "StartActThree");
        if (deserializing)
            return;
        if (!Networking.IsOwner(gameObject))
            Networking.SetOwner(Networking.LocalPlayer, gameObject);
        lateJoinScena = 3;
        RequestSerialization();

        
    }

    public void PressedButtonFour()
    {
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "StartActFour");
        if (deserializing)
            return;
        if (!Networking.IsOwner(gameObject))
            Networking.SetOwner(Networking.LocalPlayer, gameObject);
        lateJoinScena = 4;
        RequestSerialization();

        
    }
    public void PressedButtonFive()
    {
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "StartActFive");
        if (deserializing)
            return;
        if (!Networking.IsOwner(gameObject))
            Networking.SetOwner(Networking.LocalPlayer, gameObject);
        lateJoinScena = 5;
        RequestSerialization();

        
    }



    public void StartActOne()
    {
        


        for (int i = 0; i < actOneItems.Length; i++)
        {
            actOneItems[i].SetActive(true);                        
        }

        for (int i = 0; i < actTwoItems.Length; i++)
        {
            actTwoItems[i].SetActive(false);
        }
        for (int i = 0; i < actThreeItems.Length; i++)
        {
            actThreeItems[i].SetActive(false);
        }

        for (int i = 0; i < actFourItems.Length; i++)
        {
            actFourItems[i].SetActive(false);
        }
        Lava.gameObject.SetActive(false);
        for (int i = 0; i < actFiveItems.Length; i++)
        {
            actFiveItems[i].SetActive(false);
        }

        for (int i = 0; i < actOneDancerPlaces.Length; i++)
        {
            dancerPlace[i].transform.position = actOneDancerPlaces[i].position;
        }

        mainController.panelHue.value = 1;
        mainController.panelLightMode.value = 1;

        wallsAnim.Play("RazCatActWires");

        transitPostProc.SetActive(true);
        SendCustomEventDelayedSeconds("SwitchOffTransit", timeSwitchOffTransit);
                
    }

        public void StartActTwo()
    {
                

        for (int i = 0; i < actOneItems.Length; i++)
        {
            actOneItems[i].SetActive(false);
        }


        for (int i = 0; i < actTwoItems.Length; i++)
        {
            actTwoItems[i].SetActive(true);
        }
        for (int i = 0; i < actThreeItems.Length; i++)
        {
            actThreeItems[i].SetActive(false);
        }

        for (int i = 0; i < actFourItems.Length; i++)
        {
            actFourItems[i].SetActive(false);
        }
        Lava.gameObject.SetActive(false);
        for (int i = 0; i < actFiveItems.Length; i++)
        {
            actFiveItems[i].SetActive(false);
        }

        for (int i = 0; i < actTwoDancerPlaces.Length; i++)
        {
            dancerPlace[i].transform.position = actTwoDancerPlaces[i].position;
        }

        mainController.panelLightMode.value = 0;

        wallsAnim.Play("Idle");

        transitPostProc.SetActive(true);
        SendCustomEventDelayedSeconds("SwitchOffTransit", timeSwitchOffTransit);
    }

        public void StartActThree()
    {
        ceilAnim.Play("Idle");
        for (int i = 0; i < actOneItems.Length; i++)
        {
            actOneItems[i].SetActive(false);

        }

        for (int i = 0; i < actTwoItems.Length; i++)
        {
            actTwoItems[i].SetActive(false);
        }
        for (int i = 0; i < actThreeItems.Length; i++)
        {
            actThreeItems[i].SetActive(true);
        }

        for (int i = 0; i < actFourItems.Length; i++)
        {
            actFourItems[i].SetActive(false);
        }
        Lava.gameObject.SetActive(false);
        for (int i = 0; i < actFiveItems.Length; i++)
        {
            actFiveItems[i].SetActive(false);
        }

        for (int i = 0; i < actThreeDancerPlaces.Length; i++)
        {
            dancerPlace[i].transform.position = actThreeDancerPlaces[i].position;
        }

        mainController.panelLightMode.value = 0;
        ceilAnim.Play("JastOff");
        wallsAnim.Play("RazCatActBuildings");

        transitPostProc.SetActive(true);
        SendCustomEventDelayedSeconds("SwitchOffTransit", timeSwitchOffTransit);
    }

    public void StartActFour()
    {
        
        for (int i = 0; i < actOneItems.Length; i++)
        {
            actOneItems[i].SetActive(false);
        }

        for (int i = 0; i < actTwoItems.Length; i++)
        {
            actTwoItems[i].SetActive(false);
        }
        for (int i = 0; i < actThreeItems.Length; i++)
        {
            actThreeItems[i].SetActive(false);
        }

        for (int i = 0; i < actFourItems.Length; i++)
        {
            actFourItems[i].SetActive(true);
        }
        
        for (int i = 0; i < actFiveItems.Length; i++)
        {
            actFiveItems[i].SetActive(false);
        }

        for (int i = 0; i < actFourDancerPlaces.Length; i++)
        {
            dancerPlace[i].transform.position = actFourDancerPlaces[i].position;
        }

        ceilAnim.Play("CeilOpeningWithRazmotchik");

        wallsAnim.Play("Idle");

        transitPostProc.SetActive(true);
        SendCustomEventDelayedSeconds("SwitchOffTransit", timeSwitchOffTransit);
    }

    public void LavaReady()
    {
        transitPostProc.SetActive(true);
        mainController.panelHue.value = 0.05f;
        mainController.panelLightMode.value = 3;
        Lava.gameObject.SetActive(true);
        ceilAnim.Play("Razmotchik");
        SendCustomEventDelayedSeconds("SwitchOffTransit", timeSwitchOffTransit);
    }

    public void StartActFive()
    {
        ceilAnim.Play("Idle");
        for (int i = 0; i < actOneItems.Length; i++)
        {
            actOneItems[i].SetActive(false);
        }

        for (int i = 0; i < actTwoItems.Length; i++)
        {
            actTwoItems[i].SetActive(false);
        }
        for (int i = 0; i < actThreeItems.Length; i++)
        {
            actThreeItems[i].SetActive(false);
        }

        for (int i = 0; i < actFourItems.Length; i++)
        {
            actFourItems[i].SetActive(false);

        }
        Lava.gameObject.SetActive(false);
        for (int i = 0; i < actFiveItems.Length; i++)
        {
            actFiveItems[i].SetActive(true);
        }

        for (int i = 0; i < actFiveDancerPlaces.Length; i++)
        {
            dancerPlace[i].transform.position = actFiveDancerPlaces[i].position;
        }

        mainController.panelLightMode.value = 0;

        ceilAnim.SetBool("Ceil", true);
        wallsAnim.Play("Idle");

        transitPostProc.SetActive(true);
        SendCustomEventDelayedSeconds("SwitchOffTransit", timeSwitchOffTransit);
    }



    public void SwitchOffTransit()
    {
        
        transitPostProc.SetActive(false);
        for (int i = 0; i < reflProbes.Length; i++)
        {
            reflProbes[i].RenderProbe();
        }
    }

    public void Update()
    {
        if(lateJoinScena==4) magmaOffeset.SetTextureOffset("_MainTex", new Vector2(Time.time * magmaScrollSpeed, 0));
    }
}