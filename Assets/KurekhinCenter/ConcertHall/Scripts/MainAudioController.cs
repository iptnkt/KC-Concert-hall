
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;
using UnityEngine.UI;


public class MainAudioController : UdonSharpBehaviour
{
    [Header("Defaul audio States")]
    [Space(10)]

    [Header("Audio Booster")]
    public float onStageGain;
    public float onStageFar;
    public float onStageNear;
    public float offStageGain;
    public float offStageFar;
    public float offStageNear;
    [Space(5)] 

    [Header("Microphones")]
    public GameObject microphoneRed;
    public GameObject microphoneGreen;
    public GameObject microphoneBlue;

    public Transform defRed;
    public Transform defGreen;
    public Transform defBlue;
    [Space(5)]

    [Header("Microphones States")]
    public Toggle micRedInclude;
    public Toggle micRedIncrease;
    public Toggle includeRedMicrSub;
    [Space(2)]
    public Toggle micGreenInclude;
    public Toggle micGreenIncrease;
    [Space(2)]
    public Toggle micBlueInclude;
    public Toggle micBlueIncrease;
    [Space(5)]

    [Header("Microphones States")]
    public Slider highSliderGain;
    public Slider highSliderFar;
    public Slider highSliderNear;
    public Slider lowSliderGain;
    public Slider lowSliderFar;
    public Slider lowSliderNear;

    [UdonSynced, FieldChangeCallback(nameof(amplifyID))]
    private int _amplifyID;
    [UdonSynced, FieldChangeCallback(nameof(noAmplifyID))]
    private int _noAmplifyID;
    private VRCPlayerApi amplifyPlayer;
    private VRCPlayerApi noAmplifyPlayer;

    bool onStage;
    bool boosted;
    VRCPlayerApi localplayer;
    private int localPlayerID;
    
    public GameObject heldMicro;
    public Image indicator;
     
    
   
    
    


    public void Start()
    {
        if (Utilities.IsValid(Networking.LocalPlayer))
        {
            localplayer = Networking.LocalPlayer;
            localPlayerID = Networking.LocalPlayer.playerId;
        }


        localplayer = Networking.LocalPlayer;
        
        IncludeMic();
    }

    public int amplifyID
    {
        set
        {
            _amplifyID = value;
            Debug.Log("Amplify ID set to " + _amplifyID);
            SetVoiceHigh();

        }

        get => _amplifyID;
    }

    public int noAmplifyID
    {
        set
        {
            _noAmplifyID = value;
            Debug.Log("Noamplify ID set to " + _noAmplifyID);
            SetVoiceLow();

        }

        get => _noAmplifyID;
    }
    public override void OnPlayerTriggerEnter(VRCPlayerApi thisPlayer)
    {
        if (thisPlayer.isLocal)
        {
            //if (Networking.IsClogged == false && Networking.IsNetworkSettled == true) //make sure network is ready
            {
                if (Networking.IsOwner(gameObject) == false)
                {
                    Networking.SetOwner(localplayer, gameObject);
                }

                if (Networking.IsOwner(gameObject) == true)
                {
                    onStage = true;
                    Debug.Log("Player enter in audio boost zone");
                    

                        if (localPlayerID == amplifyID)
                        {
                            Debug.Log("ID already matches amplifyID, forcing sync");
                            SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "SetVoiceHigh");
                            Debug.Log("Player voice did increased");
                            boosted = true;
                        }
                        else
                        {
                            amplifyID = localPlayerID;
                            Debug.Log("Setting AmplifyID to " + amplifyID);
                            RequestSerialization();
                        }
                    


                }
            }
        }
             
        
    }

    public override void OnPlayerTriggerExit(VRCPlayerApi thisPlayer)
    {
        if (thisPlayer.isLocal)
        {
            //if (Networking.IsClogged == false && Networking.IsNetworkSettled == true) //make sure network is ready
            {
            if (Networking.IsOwner(gameObject) == false)
            { 
                Networking.SetOwner(localplayer, gameObject);
            }

            if (Networking.IsOwner(gameObject) == true)
            {
                Debug.Log("Player exit in audio boost zone");
                onStage = false;
                /*
                if ( !((microphoneRed.GetComponent<VRC_Pickup>().IsHeld && micRedIncrease.isOn) ||
                       (microphoneGreen.GetComponent<VRC_Pickup>().IsHeld && micGreenIncrease.isOn) ||
                       (microphoneBlue.GetComponent<VRC_Pickup>().IsHeld && micBlueIncrease.isOn)) )//Если не один из включённых микрофонов не в руках. Т.е. если хоть один включённый микрофон удерживается, то не надо
                */
                if (heldMicro != null)
                {
                    if (heldMicro.GetComponent<VRC_Pickup>().IsHeld && heldMicro.GetComponent<MicrophoneSub>().increase.isOn)
                    {
                        MicrophonePickUp();
                    }
                } 
                else
                {

                    

                        if (localPlayerID == noAmplifyID)
                        {
                            Debug.Log("ID already matches amplifyID, forcing sync");
                            SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "SetVoiceLow");
                            Debug.Log("Player voice did decrease");
                            boosted = false;
                        }
                        else
                        {
                            noAmplifyID = localPlayerID;
                            Debug.Log("Setting AmplifyID to " + noAmplifyID);
                            RequestSerialization();
                        }
                    
                }
            }
        }
        }

    }

    public void _OnVolumeChange()
    {
        //if (Networking.IsClogged == false && Networking.IsNetworkSettled == true) //make sure network is ready
        {
            if (Networking.IsOwner(gameObject) == false)
            {
                Networking.SetOwner(localplayer, gameObject);
            }

            if (Networking.IsOwner(gameObject) == true)
            {
                if (boosted)
                {
                    if (localPlayerID == amplifyID)
                    {
                        Debug.Log("ID already matches amplifyID, forcing sync");
                        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "SetVoiceHigh");
                        Debug.Log("Player voice did increased");
                        boosted = true;
                    }
                    else
                    {
                        amplifyID = localPlayerID;
                        Debug.Log("Setting AmplifyID to " + amplifyID);
                        RequestSerialization();
                    }
                }
                else
                {
                    if (localPlayerID == noAmplifyID)
                    {
                        Debug.Log("ID already matches amplifyID, forcing sync");
                        SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "SetVoiceLow");
                        Debug.Log("Player voice did decrease");
                        boosted = false;
                    }
                    else
                    {
                        noAmplifyID = localPlayerID;
                        Debug.Log("Setting AmplifyID to " + noAmplifyID);
                        RequestSerialization();
                    }
                }
                Debug.Log("Volume change");
            }
        }
        
    }

    public void MicrophonePickUp()
    {
        

        //if (Networking.IsClogged == false && Networking.IsNetworkSettled == true) //make sure network is ready
        {
            if (Networking.IsOwner(gameObject) == false)
            {
                Networking.SetOwner(localplayer, gameObject);
            }
            
            if (Networking.IsOwner(gameObject) == true)
            {
                if (heldMicro != null)
                {
                    Color colMic = heldMicro.GetComponent<MicrophoneSub>().col;
                    heldMicro.GetComponent<Renderer>().material.SetColor("_EmissionColor", colMic * 3);
                }
                Debug.Log("Microphone has been picked");
                if (!boosted)
                {
                    if (localplayer.isLocal)
                    {
                        

                        if (localPlayerID == amplifyID)
                        {
                            Debug.Log("ID already matches amplifyID, forcing sync");
                            SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "SetVoiceHigh");
                            Debug.Log("Player voice did increased");
                            boosted = true;
                        }
                        else
                        {
                            amplifyID = localPlayerID;
                            Debug.Log("Setting AmplifyID to " + amplifyID);
                            RequestSerialization();
                        }

                    }
                }
            }
        }
        
    }

    public void MicrophoneDrop()
    {
        
        //if (Networking.IsClogged == false && Networking.IsNetworkSettled == true) //make sure network is ready
        {
            if (Networking.IsOwner(gameObject) == false)
            {
                Networking.SetOwner(localplayer, gameObject);
            }
            
            if (Networking.IsOwner(gameObject) == true)
            {
                if (heldMicro != null)
                {
                    Color colMic = heldMicro.GetComponent<MicrophoneSub>().col;
                    heldMicro.GetComponent<Renderer>().material.SetColor("_EmissionColor", colMic * 1);
                }
                Debug.Log("Microphone has been drop");
                if (!onStage)
                {
                    if (localplayer.isLocal)
                    {
                        
                        if (localPlayerID == noAmplifyID)
                        {
                            Debug.Log("ID already matches amplifyID, forcing sync");
                            SendCustomNetworkEvent(VRC.Udon.Common.Interfaces.NetworkEventTarget.All, "SetVoiceLow");
                            Debug.Log("Player voice did decrease");
                            boosted = false;
                        }
                        else
                        {
                            noAmplifyID = localPlayerID;
                            Debug.Log("Setting AmplifyID to " + noAmplifyID);
                            RequestSerialization();
                        }
                        

                    }
                }
            }
        }
                
    }

    public void IncreaseChange()
    {
        if (heldMicro == null) return;
        Debug.Log("IncreaceChange");
        /*
        if (microphoneRed.GetComponent<VRC_Pickup>().IsHeld && micRedIncrease.isOn) MicrophonePickUp();
        if (microphoneGreen.GetComponent<VRC_Pickup>().IsHeld && micGreenIncrease.isOn) MicrophonePickUp();
        if (microphoneBlue.GetComponent<VRC_Pickup>().IsHeld && micBlueIncrease.isOn) MicrophonePickUp();

        if (!micRedIncrease.isOn) MicrophoneDrop();
        if (!micGreenIncrease.isOn) MicrophoneDrop();
        if (!micBlueIncrease.isOn) MicrophoneDrop();
        */
        if (heldMicro.GetComponent<VRC_Pickup>().IsHeld && heldMicro.GetComponent<MicrophoneSub>().increase.isOn)
        {
            MicrophonePickUp();
        }

        if (heldMicro.GetComponent<VRC_Pickup>().IsHeld && (!heldMicro.GetComponent<MicrophoneSub>().increase.isOn))
        {
            MicrophoneDrop();
        }


    }
       

    public void _OnLowReset()
    {
        lowSliderFar.value = offStageFar;
        lowSliderGain.value = offStageGain;
        lowSliderNear.value = offStageNear;
        Debug.Log("Low level Volume reseted");
    }
    public void _OnHighReset()
    {
        highSliderFar.value = onStageFar;
        highSliderGain.value = onStageGain;
        highSliderNear.value = onStageNear;
        Debug.Log("High level Volume reseted");
    }

    public void IncludeMic()
    {
       
        microphoneRed.SetActive(micRedInclude.isOn);
        if (!micRedInclude.isOn) microphoneRed.GetComponent<VRC_Pickup>().Drop();
        includeRedMicrSub.isOn = micRedInclude.isOn;

        microphoneGreen.SetActive(micGreenInclude.isOn);
        if (!micGreenInclude.isOn) microphoneGreen.GetComponent<VRC_Pickup>().Drop();

        microphoneBlue.SetActive(micBlueInclude.isOn);
        if (!micBlueInclude.isOn) microphoneBlue.GetComponent<VRC_Pickup>().Drop();
    }
    
    public void RedtoDef()
    {
        microphoneRed.GetComponent<VRC_Pickup>().Drop();
        microphoneRed.transform.position = defRed.transform.position;
        microphoneRed.transform.rotation = defRed.transform.rotation;
    }
    public void GreentoDef()
    {
        microphoneGreen.GetComponent<VRC_Pickup>().Drop();
        microphoneGreen.transform.position = defGreen.transform.position;
        microphoneGreen.transform.rotation = defGreen.transform.rotation;
    }
    public void BluetoDef()
    {
        microphoneBlue.GetComponent<VRC_Pickup>().Drop();
        microphoneBlue.transform.position = defBlue.transform.position;
        microphoneBlue.transform.rotation = defBlue.transform.rotation;
    }

    public override void OnPlayerJoined(VRCPlayerApi player)
    {
        if (Networking.IsOwner(this.gameObject))
        {
            if (Networking.IsClogged == false && Networking.IsNetworkSettled)
            {
                Debug.Log("Network not clogged and settled, owner serializing booster");
                RequestSerialization();
            }
            else
            {
                Debug.Log("Network clogged or not settled, voice booster serialization failed");
            }

        }
    }

    public void SetVoiceHigh()
    {
        if (Utilities.IsValid(VRCPlayerApi.GetPlayerById(amplifyID)))
        {
            amplifyPlayer = VRCPlayerApi.GetPlayerById(amplifyID);
            Debug.Log("Amplifying " + amplifyPlayer.displayName + "'s voice");
            amplifyPlayer.SetVoiceDistanceFar(highSliderFar.value);
            amplifyPlayer.SetVoiceGain(highSliderGain.value);
            amplifyPlayer.SetVoiceDistanceNear(highSliderNear.value);

            indicator.color = new Color(1, 0, 0);
        }

        
    }
    public void SetVoiceLow()
    {
        if (Utilities.IsValid(VRCPlayerApi.GetPlayerById(noAmplifyID)))
        {
            noAmplifyPlayer = VRCPlayerApi.GetPlayerById(noAmplifyID);
            Debug.Log("DeAmplifying " + noAmplifyPlayer.displayName + "'s voice");
            noAmplifyPlayer.SetVoiceDistanceFar(lowSliderFar.value);
            noAmplifyPlayer.SetVoiceGain(lowSliderGain.value);
            noAmplifyPlayer.SetVoiceDistanceNear(lowSliderNear.value);

            indicator.color = new Color(0, 0, 0);
        }
        
    }


    public override bool OnOwnershipRequest(VRCPlayerApi requestingPlayer, VRCPlayerApi requestedOwner)
    {
        return true;
    }

   
}
