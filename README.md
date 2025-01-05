# AIInAAL
AIInAAL - pronounced (ān-ᵊl) or 'anal' in English...fun acronym for AI-IntelArc-ArchLinux. It is a framework for installing and running popular AI software on Arch Linux using Intel Arc GPUs.

# How You Can Support Development  

[<img align="left" width="20%" src="https://media.giphy.com/media/hXMGQqJFlIQMOjpsKC/giphy.gif">](https://bmc.link/OCD_Insomniac)  

*    Please consider supporting me with [Buy Me A Coffee](https://bmc.link/OCD_Insomniac)!
*    Get the buzz out by reviewing and sharing on social networks like Facebook, Twitter (formerly), etc...
*    Consider purchasing something from the [Amazon wishlist](https://www.amazon.com/hz/wishlist/ls/25OBUY6VTN1C8?ref_=wl_share)...items I always need more of. (Mouses, Keyboards, Storage, etc...)
*    [<img align="left" width="10%" src="https://m.media-amazon.com/images/I/41CMZ4XoAJL._SS135_.jpg">](https://www.amazon.com/hz/wishlist/ls/25OBUY6VTN1C8?ref_=wl_share) [<img align="left" width="10%" src="https://i.etsystatic.com/49605844/r/il/d7369b/5752403283/il_640xN.5752403283_m6wa.jpg">](https://www.etsy.com/shop/JTGreshamExclusives)
<br clear="left"/>

# What's Currently Working (1/5/2025)
*   Fooocus
     - TF32/BF32 lack of support has made image prompts and enhancements non-functional...Otherwise seems to work as it should.
*   DeFooocus
*   Forge
*   RoopUL (via openvino)
*   Ollama + OpenWebUI
     - Installs and seems to be working. Testing is ongoing.
     - Ollama installer will install OpenWebUI as well.
*   OmniGen (WIP but generating images)
     -TODO:  Shared folder links
             Initial model download is 15GB+ - Test smaller models 

Remember that there are limitations beyond my control...like memory management, for example. AIInAAL is a framework for these packages to be installed, but ultimately, these versions, while more versitile and convenient, are the original programs at their core. I've done my best to get them to work with Intel Arc dGPUs on Arch, but this entire project is always a WIP. Keep that in mind before you try to flame me if using something you got for free misbehaves...

# Recent Notes from JT/OCD
     *  1/5/25
          I performed a fresh install of AIInAAL last night and uncovered a couple of bugs.  I found a typo in the Fooocus installaion and have fixed that.
          So far, I've reinstalled both Fooocus and Forge and am using them without issue. I changed the default port for Forge so that it would be different from that of Fooocus to allow for bookmarking in your browswer.
          I got F5-TTS to install prior to my AIInAAL reinstall last night, but I'm still in the testing phase of that...seems that there was an issue regarding the tokenizer. Says it can't find it but spits out the correct address.
          I will likely remove DeFooocus and replace RoopUL with other packages. DeFooocus just adds a couple features (most of which I either don't use or have a standalone) and it just doesn't seem to be worth my time to keep maintaining my version of it.  RoopUL is good...but I think there are some other packages that may do a better job at this point. We'll see after I do some testing.
