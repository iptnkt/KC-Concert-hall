
using System;
using UdonSharp;
using UnityEngine;
using UnityEngine.UI;
using VRC.SDKBase;
using VRC.Udon;

public class Digital_Termometr : UdonSharpBehaviour
{
    public Text textTerm;
    public int minValue;
    public int maxValue;
    int minute;
    void Start()
    {
        textTerm = GetComponent<Text>();
        float randTemp = UnityEngine.Random.value;
        Debug.Log(randTemp + " randTemp");
        float temp = Mathf.Pow(randTemp, 10) * 500 + 18; 
        temp = Mathf.Round(temp * 10)*0.1f;
        
        textTerm.text = temp + " C";
        //difValue = maxValue - minValue;
    }

    void Update()
    {  
        DateTime time = DateTime.Now;

        if((time.Second == 0)&&(minute != time.Minute))
        {
            minute = time.Minute;
            //int varTemp = UnityEngine.Random.Range(minValue, maxValue);
            float randTemp = UnityEngine.Random.value;
            float temp = Mathf.Pow(randTemp,10)*500+18;
            temp = Mathf.Round(temp * 10) * 0.1f;
            textTerm.text = temp + " C";
        }
        
        
    }

    
    string LeadingZero(int n)
    {
        return n.ToString().PadLeft(2, '0');
    }
}
