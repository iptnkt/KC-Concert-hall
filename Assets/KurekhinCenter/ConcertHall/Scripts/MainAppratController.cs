
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using UnityEngine.UI;



public class MainAppratController : UdonSharpBehaviour
{
    //Panles GROUP
    [Header("Panels")]
    public UnityEngine.UI.Slider panelHue;
    public UnityEngine.UI.Slider panelSaturate;
    public UnityEngine.UI.Slider panelPower;

    public Dropdown panelLightMode;
    Material ActualMat;
    public Material[] panelMaterial;
    public GameObject[] panel;

    public Animator panelAnimator;
    public Dropdown panelAnims;
    [Space(10)]


    //Projectors GROUP
    [Header("Projectors")]
    public Slider projectorsHue;
    public Slider projectorsSaturate;
    public Slider projectorsPower;
    public Toggle projectorsAudioLink;
    [SerializeField] 
    public VRSL.VRStageLighting_AudioLink_Static[] projectors;
    public Toggle includeProjectors;

    public GameObject[] projectorTargets;
    public Dropdown projectorTargetMode;
    public GameObject smallScenaTarget;
    public GameObject bigScenaTarget;
    public GameObject[] bigScenaTargets;
    public Button targetRandomButton;
    Vector3[] randTarget = new Vector3[8];
    public float projRandMaxZ;
    public float projRandMinZ;
    public float projRandMaxX;
    public float projRandMinX;
    public GameObject controlldProjectorTargets;
    public Slider projectorCtrlX;
    public Slider projectorCtrlZ;
    public Button targetCtrlReset;

    public Slider projectorsConeWeight;
    public Slider projectorsBlickPower;
    public Slider projectorsBlickHarsh;
    public Material blickMateral;

    public GameObject microphoneRed;
    public GameObject microphoneGreen;
    public GameObject microphoneBlue;
    [Space(10)]



    //PostProc GROUP
    [Header("Post-Processing")]
    public UnityEngine.UI.Slider postProcHue;
    public UnityEngine.UI.Slider postProcSaturate;
    public UnityEngine.UI.Slider postProcPower;
    public GameObject postProc;
    public UnityEngine.UI.Toggle includePostProc;

    //Other GROUP
    public VRC_AvatarPedestal avatarPedestal;

    void Start()
    {
        panelSaturate.value = 1;
        panelPower.value = 0.8732116f;
        

        _panelModeChange();
        //_OnPanelColorChange();
        _OnProjectorColorChange();
        _OnPostProcChange();
        _ProjectorAudioLink();
        _IncludePostProc();
        _panelAnimChange();
        _IncludeProjectors();
        _projectorTargetChange();

    }


    //Panles GROUP
    public void _OnPanelColorChange()
    {
        float panHue = panelHue.value;
        float panSat = panelSaturate.value;
        float panPow = panelPower.value;

        Color panCol = Color.HSVToRGB(panHue, panSat, 1);

        panCol *= Mathf.Pow(panPow, 3.3f);
        if (ActualMat == null)
        {
            ActualMat = panelMaterial[0];
        } 
        ActualMat.SetColor("_EmissionColor", panCol);
        

    }
    public void _panelModeChange()
    {
        int panMod = panelLightMode.value;
        ActualMat = panelMaterial[panMod];
        

        for (int i = 0; i < panel.Length; i++)
        {
            panel[i].GetComponent<Renderer>().material = ActualMat;

            //panel[i].GetComponent<Renderer>().materials[0].SetColor("_Color", panCol);
            //Material[] mats =  panel[i].GetComponent<Renderer>().materials;
            //mats[].material.SetColor("_Color", panCol);
        }
        _OnPanelColorChange();
    }

    public void _panelAnimChange()
    {
        panelAnimator.SetInteger("PanelAnimtion", panelAnims.value);
    }

    //Projectors GROUP
    public void _OnProjectorColorChange()
    {

        float prjHue = projectorsHue.value;
        float prjSat = projectorsSaturate.value;
        float prjPow = projectorsPower.value;

        Color prjCol = Color.HSVToRGB(prjHue, prjSat, 1);

        prjCol *= Mathf.Pow(prjPow, 3.3f);

        for (int i = 0; i < projectors.Length; i++)
        {
            projectors[i].LightColorTint = prjCol;
            projectors[i].ConeWidth = projectorsConeWeight.value;
        }
        //ActualMat.SetColor("_EmissionColor", prjCol);
        blickMateral.SetFloat("_ProjectionIntensity", projectorsBlickPower.value);
        blickMateral.SetFloat("_ProjectionFadeCurve", projectorsBlickHarsh.value);
    }

    public void _ProjectorAudioLink(    )
    {
        for (int i = 0; i < projectors.Length; i++)
        {
            projectors[i].EnableAudioLink = projectorsAudioLink.isOn;
        }
        Debug.Log("AudioLinkChanged");
    }
     public void _IncludeProjectors()
    {
        for (int i = 0; i < projectors.Length; i++)
        {
            projectors[i].gameObject.SetActive(includeProjectors.isOn);
        }
    }

    public void _projectorTargetChange()
    {
        targetRandomButton.gameObject.SetActive(false);
        targetCtrlReset.gameObject.SetActive(false);
        projectorCtrlX.gameObject.SetActive(false);
        projectorCtrlZ.gameObject.SetActive(false);

        for (int i = 0; i < projectorTargets.Length; i++)

        {
            //projectors[i].targetToFollow = projectorTargets[i].transform;
            projectorTargets[i].transform.SetParent(projectors[i].transform);
        }

            switch (projectorTargetMode.value)
        {
            case 0: //Small Scena
                for (int i = 0; i < projectorTargets.Length; i++)
                {
                    projectorTargets[i].transform.position = smallScenaTarget.transform.position;
                }
                break;
            case 1: //Big Scena
                for (int i = 0; i < projectorTargets.Length; i++)
                {
                    projectorTargets[i].transform.position = bigScenaTarget.transform.position;
                }
                break;
            case 2: //Big Scena shape
                for (int i = 0; i < projectorTargets.Length; i++)
                {
                    projectorTargets[i].transform.position = bigScenaTargets[i].transform.position;
                }
                break;
            case 3: //Random
                targetRandomButton.gameObject.SetActive(true);
                for (int i = 0; i < projectorTargets.Length; i++)
                {                    
                    //randTarget[i].Set(Random.Range(projRandMinX, projRandMaxX),0, Random.Range(projRandMinZ, projRandMaxZ));
                    randTarget[i] = new Vector3(Random.Range(projRandMinX, projRandMaxX), 0, Random.Range(projRandMinZ, projRandMaxZ));
                    //randTarget[i].
                    projectorTargets[i].transform.position = randTarget[i];
                }
                break;
            case 4: //Controlled

                targetCtrlReset.gameObject.SetActive(true);
                projectorCtrlX.gameObject.SetActive(true);
                projectorCtrlZ.gameObject.SetActive(true);
                //controlldProjectorTargets.transform.position.Set(projectorCtrlX.value, 0, projectorCtrlZ.value);
                controlldProjectorTargets.transform.position = new Vector3(projectorCtrlX.value, 0, projectorCtrlZ.value);
                Debug.Log("controlldProjectorTarget " + controlldProjectorTargets.transform.position);
                for (int i = 0; i < projectorTargets.Length; i++)
                {
                    projectorTargets[i].transform.position = controlldProjectorTargets.transform.position;
                }
                break;

            case 5: //microphoneRed

                for (int i = 0; i < projectorTargets.Length; i++)
                {
                    projectorTargets[i].transform.SetParent(microphoneRed.transform);
                    projectorTargets[i].transform.localPosition = new Vector3(0, 0, 0);
                } 
                break;

            case 6://microphoneGreen

                for (int i = 0; i < projectorTargets.Length; i++)
                {
                    projectorTargets[i].transform.SetParent(microphoneGreen.transform);
                    projectorTargets[i].transform.localPosition = new Vector3(0, 0, 0);
                }
                break;

            case 7://microphoneBlue

                for (int i = 0; i < projectorTargets.Length; i++)
                {
                    projectorTargets[i].transform.SetParent(microphoneBlue.transform);
                    projectorTargets[i].transform.localPosition = new Vector3(0, 0, 0);
                }
                break;
            default:               
                break;
        }
    }
    public void _RandButtonPressed()
    {
        projectorTargetMode.value = 3;
        _projectorTargetChange();
    }
    public void _CtrlResetPressed()
    {
        projectorCtrlX.value = -60;
        projectorCtrlZ.value = -45;
        projectorTargetMode.value = 4;
        _projectorTargetChange();
    }



    //PostProc GROUP
    public void _OnPostProcChange()
    {
        float pPHue = postProcHue.value;
        float pPSat = postProcSaturate.value;
        float pPPow = postProcPower.value;

        Material pPMat = postProc.GetComponent<Renderer>().material;

        Color pPCol = Color.HSVToRGB(pPHue, pPSat, 1);
        pPMat.SetColor("_EmissionColor", pPCol);

        //pPPow = pPPow * 10;
        pPPow = 9*(Mathf.Pow(pPPow, 2))+1;
        //pPPow = Mathf.Clamp(pPPow, 1, 10);
        Debug.Log("pPPow = " + pPPow);
        pPMat.SetFloat("_Light", pPPow);
        //Debug.Log(lightPower + "lightPower");
    }

    public void _IncludePostProc()
    {
        postProc.GetComponent<Renderer>().enabled = includePostProc.isOn;
    }


    public void ChangeAvatar()
    {
        if (Networking.IsOwner(gameObject) == false)
        {
            Networking.SetOwner(Networking.LocalPlayer, gameObject);
        }
        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "AllAvatarChange");
    }
    public void AllAvatarChange()
    {
        avatarPedestal.SetAvatarUse(Networking.LocalPlayer);
        Debug.Log("AvatarChanged");
    }
}
