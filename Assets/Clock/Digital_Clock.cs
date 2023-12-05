
using System;
using UdonSharp;
using UnityEngine;
using UnityEngine.UI;
using VRC.SDKBase;
using VRC.Udon;

public class Digital_Clock : UdonSharpBehaviour
{
    public Text textClock;
    public bool withSecond;
    void Start()
    {
        textClock = GetComponent<Text>();
    }

    void Update()
    {
        DateTime time = DateTime.Now;

        string hour = LeadingZero(time.Hour);
        string minute = LeadingZero(time.Minute);
        string second = LeadingZero(time.Second);
        if (withSecond == true)
        {
            textClock.text = hour + ":" + minute + ":" + second;
        }
        else
        {
            textClock.text = hour + ":" + minute;
        }
    }

    string LeadingZero(int n)
    {
        return n.ToString().PadLeft(2, '0');
    }
}
