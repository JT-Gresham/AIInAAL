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
     - Issues with OOM if setting resolution too high. Most likely issue with Intel extensions for pytorch...my guess.
     - Still works pretty well..especially for merging which is about all I use it for in this current state.
*   Ollama + OpenWebUI
     - Installs and seems to be working if you install Ollama directly to your OS rather than in a container. Testing is ongoing.
     - Ollama installer will install OpenWebUI as well.
*   OmniGen (WIP but generating images)
     -TODO:  Shared folder links
             Initial model download is 15GB+ - Test smaller models 

Remember that there are limitations beyond my control...like memory management, for example. AIInAAL is a framework for these packages to be installed, but ultimately, these versions, while more versitile and convenient, are the original programs at their core. I've done my best to get them to work with Intel Arc dGPUs on Arch, but this entire project is always a WIP. Keep that in mind before you try to flame me if using something you got for free misbehaves...

# Recent Notes from JT/OCD
     *  2/5/25
          I noticed today that GitHub has blocked remote access (ban/block) to C0untFloyd's RoopUL repository.  Simply, that means my installer and modification scripts won't work since the base program can't be downloaded.
          I have removed RoopUL from the "What's Working" list above accordingly. It's funny that just last month I noted that I was looking for a replacement. Now, it seems, I have to...so I'll be looking at that too.  Too bad about RoopUL. It was a fun toy to mess around with.
          I have Ollama listed above, but I realized that I had installed Ollama to my root rather than in the AIInAAL environment.  That explains why it was working well even though I had seen posts stating that GPUs were not usable in (docker) containers. I've been working on getting it to work within the AIInAAL container, and I've gotten it to install and run...but it's only using my CPU...which is SLOOOOOOW.  The problem is that Ollama isn't launched in a straightforward way. The devs decided that it would be smart to construct the executable in such a way that I can't even open it with a text editor and look at the code. Can you say "CLOSED SOURCE"?  I can poke around in the other files, but really, I need to add extensions to the executable or figure out some other way to set the necessary variables to be compatible with Intel GPUs. I'm blown away that there are packages out already that will handle this, but the Ollama devs just don't want to support Intel Arc...literally, in the init.py file you can see case statements for Nvidia or AMD only...not even an else (*) case entry.  I'd add one for Intel if I knew the what and where for the other variables.  I may just mess around with it anyway.  If Ollama is installed directly to your PC, it will work fine the way I had it before...but if you containerize it, there's issues.  Like I said, I do have it installed strictly in my environment now, but there's no actual GPU usage.  That's weird since the ipex debugging info shows that my GPU is recognized, but the Ollama server always reverts back to using a default CPU runner...if only it was as easy as using ipexrun to start the ollama server....but no.
          I've been tooling around with several packages off and on bouncing between them....just chipping away at my list of packages I want to get working.  Fooocus is working gangbusters though...too bad the primary dev decided to abandon it.  I'm looking to get another fork working...one that's being updated.
     *  1/5/25
          I performed a fresh install of AIInAAL last night and uncovered a couple of bugs.  I found a typo in the Fooocus installaion and have fixed that.
          So far, I've reinstalled both Fooocus and Forge and am using them without issue. I changed the default port for Forge so that it would be different from that of Fooocus to allow for bookmarking in your browswer.
          I got F5-TTS to install prior to my AIInAAL reinstall last night, but I'm still in the testing phase of that...seems that there was an issue regarding the tokenizer. Says it can't find it but spits out the correct address.
          I will likely remove DeFooocus and replace RoopUL with other packages. DeFooocus just adds a couple features (most of which I either don't use or have a standalone) and it just doesn't seem to be worth my time to keep maintaining my version of it.  RoopUL is good...but I think there are some other packages that may do a better job at this point. We'll see after I do some testing.
