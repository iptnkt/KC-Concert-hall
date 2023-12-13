
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

public class SoundConcertKatushki : UdonSharpBehaviour

{
   
public AudioSource Lava;
public AudioSource Press;
public AudioSource Rubilnik;
public AudioSource Shutdown;
public AudioSource Svarka;

   


   void Update(
   )
   {

   }

    public void play_Lava()
    {
    Lava.Stop();
        Lava.Play();
    }

    public void play_Press()
    {
     Press.Stop();
        Press.Play();
    }
    public void play_Rubilnik()
    {
    Rubilnik.Stop();
        Rubilnik.Play();
    }
    
    public void play_Shutdown()
    {
        Shutdown.Stop();
    Shutdown.Play();
    }
    public void play_Svarka()
    {
    Svarka.Stop();
        Svarka.Play();
    }
    
    public void stop_all()
    {
     Lava.Stop();
      Press.Stop();
        Rubilnik.Stop();
        Shutdown.Stop();
        Svarka.Stop();
          

    }
}

