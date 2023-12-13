
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using UnityEngine.UI;

public class RazCatActChanger : UdonSharpBehaviour
{
    [Header("Items")]
    public GameObject[] actZeroItems;
    public GameObject[] actZeroNoItems;
    public GameObject[] actOneItems; //Wires
    public GameObject[] actTwoItems; //Plaets
    public GameObject[] actThreeItems;
    public GameObject[] actThreeTwoItems;//Puildings
    public GameObject[] actFourItems; //Melting
    public GameObject Lava; 
    public GameObject[] actFiveItems;//Electro
    public GameObject IncludeError;
    public GameObject PostProcError;
    public GameObject[] dancerPlace;
    public GameObject[] dancerPlatforms;

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

    [Header("ForAnimWalls")]
    public Texture[] sovietPosters;
    public Material postersMat;
    public Material simpleBeton;
    private GameObject[] panel = new GameObject[68];

    [Header("Another controllers")]
    public MainAppratController mainController;
    public Animator ceilAnim;
    public Animator wallsAnim;
    public Animator transformerAnim;
    public Toggle platforVisualizerToggle;
    public Toggle hidderItems;

    //Sync
    [UdonSynced] int lateJoinScena;
    private int curretAction;
    private bool deserializing;

    //Trash
    public Material magmaOffeset;
    public float magmaScrollSpeed;
    public Text test ;



    private void Start()
    {
        ceilAnim.Play("Idle");


        for (int i = 0; i < actZeroNoItems.Length; i++)
        {
            actZeroNoItems[i].SetActive(false);
        }

        for (int i = 0; i < actZeroItems.Length; i++)
        {
            actZeroItems[i].SetActive(true);
        }

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
        for (int i = 0; i < actThreeTwoItems.Length; i++)
        {
            actThreeTwoItems[i].SetActive(false);
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

       

            for (int i = 0; i < mainController.panel.Length; i++)
        {
            panel[i] = mainController.panel[i]; 
        }
        postersMat.SetTexture("_Tex", sovietPosters[1]);
    }

    public void VisualizeDancerPlatforms()
    {
        if (platforVisualizerToggle.isOn)
        {
            for (int i = 0; i < dancerPlatforms.Length; i++)
            {
                dancerPlatforms[i].GetComponent<MeshRenderer>().enabled = true;
            }
        }
        else
        {
            for (int i = 0; i < dancerPlatforms.Length; i++)
            {
                dancerPlatforms[i].GetComponent<MeshRenderer>().enabled = false;
            }
        }
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

    public void PressedButtonZero()
    {
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "StartActZero");

        if (deserializing)
            return;
        if (!Networking.IsOwner(gameObject))
            Networking.SetOwner(Networking.LocalPlayer, gameObject);
        lateJoinScena = 0;
        RequestSerialization();


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

    public void PressedButtonThreeTwo()
    {
        if (lateJoinScena != 3) return;
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "StartActThreeTwo");
        
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
        //lateJoinScena = 5;
        RequestSerialization();

        
    }

    public void PressedButtonSIx()
    {
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "StartActSix");
        if (deserializing)
            return;
        if (!Networking.IsOwner(gameObject))
            Networking.SetOwner(Networking.LocalPlayer, gameObject);
        lateJoinScena = 6;
        RequestSerialization();


    }

    public void StartActZero()
    {
        

        for (int i = 0; i < actZeroItems.Length; i++)
        {
            actZeroItems[i].SetActive(true);
        }

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
        for (int i = 0; i < actThreeTwoItems.Length; i++)
        {
            actThreeTwoItems[i].SetActive(false);
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

        
        ceilAnim.Play("Idle");
        wallsAnim.Play("Idle");

        mainController.includePostProc.isOn = false;
        transitPostProc.SetActive(true);
        SendCustomEventDelayedSeconds("SwitchOffTransit", timeSwitchOffTransit);

    }

    public void StartActOne()
    {

        for (int i = 0; i < actZeroItems.Length; i++)
        {
            actZeroItems[i].SetActive(false);
        }

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
        for (int i = 0; i < actThreeTwoItems.Length; i++)
        {
            actThreeTwoItems[i].SetActive(false);
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

        ceilAnim.Play("Idle");
        wallsAnim.Play("RazCatActWires");

        mainController.includePostProc.isOn = false;
        transitPostProc.SetActive(true);
        SendCustomEventDelayedSeconds("SwitchOffTransit", timeSwitchOffTransit);
                
    }

        public void StartActTwo()
    {
        for (int i = 0; i < actZeroItems.Length; i++)
        {
            actZeroItems[i].SetActive(false);
        }

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
        for (int i = 0; i < actThreeTwoItems.Length; i++)
        {
            actThreeTwoItems[i].SetActive(false);
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

        ceilAnim.Play("Idle");
        wallsAnim.Play("Idle");

        mainController.includePostProc.isOn = false;
        transitPostProc.SetActive(true);
        SendCustomEventDelayedSeconds("SwitchOffTransit", timeSwitchOffTransit);
    }

        public void StartActThree()
    {
        for (int i = 0; i < actZeroItems.Length; i++)
        {
            actZeroItems[i].SetActive(false);
        }
        for (int i = 0; i < actOneItems.Length; i++)
        {
            actOneItems[i].SetActive(false);

        }

        for (int i = 0; i < actTwoItems.Length; i++)
        {
            actTwoItems[i].SetActive(false);
        }
        
        for (int i = 0; i < actThreeTwoItems.Length; i++)
        {
            actThreeTwoItems[i].SetActive(false);
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
        for (int i = 0; i < actThreeItems.Length; i++)
        {
            actThreeItems[i].SetActive(true);
        }
        for (int i = 0; i < actThreeDancerPlaces.Length; i++)
        {
            dancerPlace[i].transform.position = actThreeDancerPlaces[i].position;
        }

        mainController.panelLightMode.value = 0;

        ceilAnim.Play("Idle");
        wallsAnim.Play("OpenAndClose");

        for (int i = 0; i < panel.Length; i++)
        {
            Material[] mat =  panel[i].GetComponent<Renderer>().materials;
            mat[1] = postersMat;
            panel[i].GetComponent<Renderer>().materials = mat;
        }

        mainController.includePostProc.isOn = false;
        transitPostProc.SetActive(true);
        SendCustomEventDelayedSeconds("SwitchOffTransit", timeSwitchOffTransit);
    }

    public void StartActThreeTwo()
    {
        for (int i = 0; i < actZeroItems.Length; i++)
        {
            actZeroItems[i].SetActive(false);
        }
        for (int i = 0; i < actThreeItems.Length; i++)
        {
            actThreeItems[i].SetActive(false);
        }
        for (int i = 0; i < actThreeTwoItems.Length; i++)
        {
            actThreeTwoItems[i].SetActive(true);
        }

        ceilAnim.Play("BuildCity");
        wallsAnim.Play("OpenAndClose");
        transitPostProc.SetActive(true);
        SendCustomEventDelayedSeconds("SwitchOffTransit", timeSwitchOffTransit);
    }

    public void TimeToChangePoster()
    {
        int rand = Random.Range(0, 19);
        postersMat.SetTexture("_Tex", sovietPosters[rand]);

    }
    public void StartActFour()
    {
        for (int i = 0; i < actZeroItems.Length; i++)
        {
            actZeroItems[i].SetActive(false);
        }
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
        for (int i = 0; i < actThreeTwoItems.Length; i++)
        {
            actThreeTwoItems[i].SetActive(false);
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

        for (int i = 0; i < panel.Length; i++)
        {
            Material[] mat = panel[i].GetComponent<Renderer>().materials;
            mat[1] = simpleBeton;
            panel[i].GetComponent<Renderer>().materials = mat;
        }

        mainController.includePostProc.isOn = false;


        transitPostProc.SetActive(true);
        SendCustomEventDelayedSeconds("SwitchOffTransit", timeSwitchOffTransit);
    }

    

    public void LavaReady()
    {
        mainController.postProcHue.value = 0.02f;
        mainController.postProcPower.value = 0.15f;
        mainController.postProcSaturate.value = 0.5f;
        mainController.includePostProc.isOn = true;
        transitPostProc.SetActive(true);
        mainController.panelHue.value = 0.05f;
        mainController.panelLightMode.value = 3;
        Lava.gameObject.SetActive(true);
        ceilAnim.Play("Razmotchik");
        SendCustomEventDelayedSeconds("SwitchOffTransit", timeSwitchOffTransit);
    }

    public void StartActFive()
    {
        for (int i = 0; i < actZeroItems.Length; i++)
        {
            actZeroItems[i].SetActive(false);
        }
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
        for (int i = 0; i < actThreeTwoItems.Length; i++)
        {
            actThreeTwoItems[i].SetActive(false);
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

        ceilAnim.Play("JastOff");
        wallsAnim.Play("Idle");
        transformerAnim.Play("DoorClose");

        mainController.postProcHue.value = 0.55f;
        mainController.postProcPower.value = 0f;
        mainController.postProcSaturate.value = 0.5f;
        mainController.includePostProc.isOn = true;
        

        transitPostProc.SetActive(true);
        SendCustomEventDelayedSeconds("SwitchOffTransit", timeSwitchOffTransit);
    }

    public void StartActSix()
    {
        transformerAnim.Play("OpenDoor");
    }

    public void ErrorMessage()
    {
        PostProcError.SetActive(true);
    }
    public void SwitchOffTransit()
    {
        for (int i = 0; i < actZeroNoItems.Length; i++)
        {
            if (lateJoinScena == 0)
            {
                actZeroNoItems[i].SetActive(false);
            }else
            {
                actZeroNoItems[i].SetActive(true);
            }
        }
        transitPostProc.SetActive(false);
        for (int i = 0; i < reflProbes.Length; i++)
        {
            reflProbes[i].RenderProbe();
        }

        
    }

    public void HideItems()
    {
        if (hidderItems.isOn)
        {
            for (int i = 0; i < actZeroNoItems.Length; i++)
            {
                actZeroNoItems[i].GetComponent<MeshRenderer>().enabled = false;
            }
        }
        else
        {
            for (int i = 0; i < actZeroNoItems.Length; i++)
            {
                actZeroNoItems[i].GetComponent<MeshRenderer>().enabled = true;
            }
        }
    }

}