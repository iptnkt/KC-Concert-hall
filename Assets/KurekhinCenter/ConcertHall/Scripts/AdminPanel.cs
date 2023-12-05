
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using UnityEngine.UI;

public class AdminPanel : UdonSharpBehaviour
{
    [Header("Locker")]
    public UnityEngine.UI.Toggle locker;

    public UnityEngine.UI.Slider[] sliders;
    public UnityEngine.UI.Toggle[] toggles;
    public UnityEngine.UI.Dropdown[] dropdowns;
    public UnityEngine.UI.Button[] buttons;


    [Header("Tabs")]
    public Button teleports;
    public GameObject teleportsTab;
    public Button presentation;
    public GameObject presentationTab;
    public Button accesability;
    public GameObject accesabilityTab;
    public Button dancerPlace;
    public GameObject dancerPlaceTab;   

    [Header("Other")]
    public GameObject mainAdminPanelHolder;
    public Toggle attatchToLockalPlayer;
    public GameObject staffTablet;
    public Transform micTarget;
    public Toggle includeRedMicrSub;
    public Toggle includeRedMicroOriginal;
    public GameObject microphoneR;


    void Start()
    {
        lockerValueChange();
    }

    public void lockerValueChange()
    {

        for (int i = 0; i < sliders.Length; i++)
        {
            if (sliders[i] != null)
            {
                sliders[i].interactable = !locker.isOn;
            }
        }

        for (int i = 0; i < toggles.Length; i++)
        {
            if (toggles[i] != null)
            {
                toggles[i].interactable = !locker.isOn;
            }
        }

        for (int i = 0; i < dropdowns.Length; i++)
        {
            if (dropdowns[i] != null)
            {
                dropdowns[i].interactable = !locker.isOn;
            }
        }
         
        for (int i = 0; i < buttons.Length; i++)
        {
            if (buttons[i] != null)
            {
                buttons[i].interactable = !locker.isOn;
            }
        }
    }

    public void ChangeToTeleportsTab()
    {
        teleportsTab.SetActive(true);
        presentationTab.SetActive(false);
        accesabilityTab.SetActive(false);
        dancerPlaceTab.SetActive(false);
    }
    public void ChangeToPresentationTab()
    {
        teleportsTab.SetActive(false);
        presentationTab.SetActive(true);
        accesabilityTab.SetActive(false);
        dancerPlaceTab.SetActive(false);
    }
    public void ChangeToAccesabilityTab()
    {
        teleportsTab.SetActive(false);
        presentationTab.SetActive(false);
        accesabilityTab.SetActive(true);
        dancerPlaceTab.SetActive(false);
    }
    public void ChangeToDancerPlaceTab()
    {
        teleportsTab.SetActive(false);
        presentationTab.SetActive(false);
        accesabilityTab.SetActive(false);
        dancerPlaceTab.SetActive(true);
    }

        /*
        public void attachLockalPlayer()
        {
            if(attatchToLockalPlayer.isOn)
            {
              //  mainPickUp.transform.SetParent(Networking.LocalPlayer.gameObject.transform);
            }
            else
            {
                mainPickUp.transform.SetParent(staffTablet.transform);
            }
        }*/

        private void Update()
    {
        if (attatchToLockalPlayer.isOn)
        {
            mainAdminPanelHolder.transform.position = Networking.LocalPlayer.GetPosition();
           // mainAdminPanelHolder.transform.rotation = Networking.LocalPlayer.GetRotation();
        }
    }


    public void IncludeMic() 
    {
        includeRedMicroOriginal.isOn = includeRedMicrSub.isOn;
        
    }

    public void getMicrophoneRed()
    {
        microphoneR.transform.position = micTarget.position;
    }
}
